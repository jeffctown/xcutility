//
//  MissingFileAnalyzerStep.swift
//  XcodeMissingFramework
//
//  Created by Jeff Lett on 2/12/19.
//

import Foundation
import PathKit

public struct MissingFileAnalyzerStep: Step {
    public init() {}

    public func run(context: StepPipelineContext) {
        context.missingFiles = Files(array: context.files.all.filter { !$0.isUsed })
        for missingFile in context.missingFiles.all.sorted() {
            print("\(missingFile.filename)")
        }
        print("Total Missing Files Found: \(context.missingFiles.all.count)")
    }
}
