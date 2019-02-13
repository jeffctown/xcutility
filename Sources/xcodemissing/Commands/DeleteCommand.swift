//
//  DeleteCommand.swift
//  xcodemissing
//
//  Created by Jeff Lett on 2/11/19.
//

import Commandant
import Foundation
import Result

struct DeleteCommand: CommandProtocol {
    public let verb = "delete"
    public let function = "Delete files that are not referenced in any Xcode projects"
    
    func run(_ options: Options) -> Result<(), CommandantError<()>> {
        print("Deleting files in: \(options.path)")
        return StepPipeline(steps: [
            FileGatherStep(),
            XcodeReferenceGatherStep(),
            UnusedFileAnalyzerStep(),
            DeleteFileStep()
            ], options: options
        ).run()
    }
}
