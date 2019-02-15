//
//  StepPipeline.swift
//  XcodeMissingFramework
//
//  Created by Jeff Lett on 2/12/19.
//

import Foundation
import xcodeproj
import PathKit

public protocol Step {
    func run(context: StepPipelineContext) throws
}

public struct StepPipeline {

    let steps: [Step]
    let context: StepPipelineContext

    public init(steps: [Step], context: StepPipelineContext) {
        self.steps = steps
        self.context = context
        if context.verbose {
            print("Verbose Logging Enabled.")
        }
    }

    public func run() throws {
        for step in steps {
            try step.run(context: context)
        }
    }
}
