//
//  FindCommand.swift
//  xcodemissing
//
//  Created by Jeff Lett on 2/11/19.
//

import Foundation
import Commandant
import Result

struct FindCommand: CommandProtocol {
    public let verb = "find"
    public let function = "Find files that are not referenced in any Xcode projects"
    
    func run(_ options: Options) -> Result<(), CommandantError<()>> {
        print("Finding files in: \(options.path)")
        return StepPipeline(steps: [
            FileGatherStep(),
            XcodeReferenceGatherStep(),
            UnusedFileAnalyzerStep()
            ], options: options
        ).run()
    }
    
}
