//
//  DeleteFileStep.swift
//  xcodemissing
//
//  Created by Jeff Lett on 2/12/19.
//

import Foundation
import PathKit

struct DeleteFileStep: Step {
    func run(context: StepPipelineContext) throws {
        for unusedFile in context.unusedFiles {
            let path = Path(unusedFile)
            print("Deleting File: \(unusedFile)")
            try path.delete()
        }
    }
}
