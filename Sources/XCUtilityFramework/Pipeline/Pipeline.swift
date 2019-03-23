//
//  StepPipeline.swift
//  XCUtilityFramework
//
//  Created by Jeff Lett on 2/12/19.
//

import Foundation

public protocol Step {
    mutating func run(context: PipelineState) throws
}

public struct Pipeline {
    let steps: [Step]
    let context: PipelineState

    public init(steps: [Step], context: PipelineState) {
        self.steps = steps
        self.context = context
        if context.config.verbose {
            Log.shared.log("Verbose Logging Enabled.")
        }
    }

    public mutating func run() throws {
        for var step in steps {
            try step.run(context: context)
        }
    }
}
