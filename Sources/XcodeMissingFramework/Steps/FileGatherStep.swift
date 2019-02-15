//
//  FileGatherStep.swift
//  XcodeMissingFramework
//
//  Created by Jeff Lett on 2/12/19.
//

import Foundation
import PathKit

public struct FileGatherStep: Step {

    public init() {}
    
    public func run(context: StepPipelineContext) throws {
        let files = try context.path.recursiveFilter { $0.isValid(context: context) }
        for file in files {
            context.files.add(File(filename: file.absolute().string))
        }
    }
}
