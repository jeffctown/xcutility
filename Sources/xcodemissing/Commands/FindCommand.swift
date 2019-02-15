//
//  FindCommand.swift
//  xcodemissing
//
//  Created by Jeff Lett on 2/11/19.
//

import Foundation
import Commandant
import Result
import XcodeMissingFramework

public struct FindCommand: CommandProtocol {
    public let verb = "find"
    public let function = "Find files that are not referenced in any Xcode projects"

    public init() {}

    public func run(_ options: Options) -> Result<(), CommandantError<()>> {
        print("Finding files in: \(options.path)")
        let context = StepPipelineContext(verbose: options.verbose, extensions: options.extensions, path: options.path)
        do {
            try StepPipeline(steps: [
                FileGatherStep(),
                XcodeReferenceGatherStep(),
                UnusedFileAnalyzerStep()
                ], context: context
            ).run()
            return .success(())
        } catch {
            return .failure(.usageError(description: error.localizedDescription
                ))
        }
    }

}
