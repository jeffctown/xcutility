//
//  CommandProtocol+Extension.swift
//  xcutility
//
//  Created by Jeff Lett on 3/8/19.
//

import Commandant
import Foundation
import Result
import XCUtilityFramework

protocol CommandProvider {
    var command: AbstractStepFactory.Command { get }

    func beginMessage(path: String) -> String
}

extension CommandProtocol where Self: CommandProvider {
    func run<T: ConfigurationOptions>(_ options: T) -> Result<(), CommandantError<()>> {
        let beginMessage = self.beginMessage(path: options.path)
        print(beginMessage)
        let stepFactory = AbstractStepFactory.stepFactory(for: self.command)
        let steps = stepFactory.steps(delete: options.delete)
        do {
            let config = try Configuration(options: options)
            let context = PipelineState(config: config)
            var pipeline = Pipeline(steps: steps, context: context)
            try pipeline.run()
            return .success(())
        } catch {
            return .failure(.usageError(description: error.localizedDescription))
        }
    }
}

extension CommandProtocol {
    static var switchVerbose: Switch {
        return Switch(flag: "v", key: "verbose", usage: "enable verbose logging")
    }

    static var switchDelete: Switch {
        return Switch(flag: "d", key: "delete", usage: "delete files")
    }

    static var optionPath: Option<String> {
        return Option(key: "path", defaultValue: FileManager.default.currentDirectoryPath, usage: "the path to search")
    }

    static var optionExtensions: Option<[String]> {
        return Option(key: "extensions",
                      defaultValue: [],
                      usage: "limit the search to files having specific file extensions")
    }

    static var optionConfig: Option<String> {
        return Option(key: "config",
                      defaultValue: Configuration.fileName,
                      usage: "the path to XcodeTools configuration file")
    }
}
