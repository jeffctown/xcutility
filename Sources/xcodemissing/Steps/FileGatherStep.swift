//
//  FileGatherStep.swift
//  xcodemissing
//
//  Created by Jeff Lett on 2/12/19.
//

import Foundation
import PathKit

struct FileGatherStep: Step {
    
    func run(context: StepPipelineContext) throws {
        let files = try context.path.recursiveFilter { $0.isValid(context: context) }
        for file in files {
            context.files[file.absolute().string] = 0
        }
    }
}
