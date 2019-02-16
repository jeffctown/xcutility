//
//  DeleteFileStep.swift
//  XcodeMissingFramework
//
//  Created by Jeff Lett on 2/12/19.
//

import Foundation
import PathKit

public struct DeleteFileStep: Step {
    public init() {}

    public func run(context: StepPipelineContext) throws {
        for unusedFile in context.unusedFiles.all {
            let path = Path(unusedFile.filename)
            print("Deleting File: \(unusedFile.filename)")
            try path.delete()
        }
    }
}
