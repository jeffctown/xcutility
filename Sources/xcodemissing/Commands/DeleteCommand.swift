//
//  DeleteCommand.swift
//  xcodemissing
//
//  Created by Jeff Lett on 2/11/19.
//

import Foundation
import Commandant
import Result
import XcodeMissingFramework

struct DeleteCommand: CommandProtocol {
    let verb = "delete"
    let function = "Delete files that are not referenced in any Xcode projects"

    func run(_ options: Options) -> Result<(), CommandantError<()>> {
        print("Deleting files in: \(options.path)")
        let context = StepPipelineContext(verbose: options.verbose, extensions: options.extensions, path: options.path)
        do {
            try StepPipeline(steps: [
                FileGatherStep(),
                XcodeReferenceGatherStep(),
                UnusedFileAnalyzerStep(),
                DeleteFileStep()
                ], context: context
            ).run()
            return .success(())
        } catch {
            return .failure(.usageError(description: error.localizedDescription))
        }
    }
}
