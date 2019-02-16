//
//  UnusedFileAnalyzerStep.swift
//  XcodeMissingFramework
//
//  Created by Jeff Lett on 2/12/19.
//

import Foundation
import PathKit

public struct UnusedFileAnalyzerStep: Step {
    
    public init() {}
    
    public func run(context: StepPipelineContext) {
        context.unusedFiles = Files(array: context.files.all.filter { !$0.isUsed })
        for unusedFile in context.unusedFiles.all.sorted() {
            print("\(unusedFile.filename)")
        }
        print("Total Unused Paths Found: \(context.unusedFiles.all.count)")
    }
}
