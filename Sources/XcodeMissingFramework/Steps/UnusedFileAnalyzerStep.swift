//
//  UnusedFileAnalyzerStep.swift
//  xcodemissing
//
//  Created by Jeff Lett on 2/12/19.
//

import Foundation
import PathKit

public struct UnusedFileAnalyzerStep: Step {
    
    public init() {}
    
    public func run(context: StepPipelineContext) {
        context.unusedFiles = context.files.keys.filter { context.files[$0] == 0 }.sorted()
        for unusedFile in context.unusedFiles {
            print("\(unusedFile)")
        }
        print("Total Unused Paths Found: \(context.unusedFiles.count)")
    }
}
