//
//  DeleteMissingFileStep.swift
//  XcodeMissingFramework
//
//  Created by Jeff Lett on 2/12/19.
//

import Foundation
import PathKit

public struct DeleteMissingFileStep: Step {
    public init() {}

    public func run(context: StepPipelineContext) throws {
        for missingFile in context.missingFiles.all {
            let path = Path(missingFile.filename)
            print("Deleting File: \(missingFile.filename)")
            try path.delete()
        }
    }
}
