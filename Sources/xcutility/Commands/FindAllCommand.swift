//
//  FindAllCommand.swift
//  xcutility
//
//  Created by Jeff Lett on 3/8/19.
//

import Commandant
import Foundation
import Result
import XCUtilityFramework

struct FindAllCommand: CommandProtocol, CommandProvider {
    // MARK: - CommandProvider

    let command: AbstractStepFactory.Command = .findAll

    func beginMessage(path: String) -> String {
        return "Finding files in: \(path)"
    }

    // MARK: - CommandProtocol

    let verb = "all"
    let function = "Find files that are not built or referenced in any Xcode projects"

    // MARK: - OptionsProtocol

    struct Options: OptionsProtocol, ConfigurationOptions {
        let path: String
        let extensions: [String]
        let verbose: Bool
        let delete: Bool
        let config: String

        static func create(_ path: String) -> ([String]) -> (Bool) -> (Bool) -> (String) -> Options {
            return { extensions in { verbose in { delete in { config in Options(path: path,
                                                                                extensions: extensions,
                                                                                verbose: verbose,
                                                                                delete: delete,
                                                                                config: config) } } } }
        }

        static func evaluate(_ mode: CommandMode) -> Result<Options, CommandantError<CommandantError<()>>> {
            return create
                <*> mode <| optionPath
                <*> mode <| optionExtensions
                <*> mode <| switchVerbose
                <*> mode <| switchDelete
                <*> mode <| optionConfig
        }
    }
}
