//
//  StepPipeline.swift
//  xcodemissing
//
//  Created by Jeff Lett on 2/12/19.
//

import Foundation
import xcodeproj
import Commandant
import Result
import PathKit

protocol Step {
    func run(context: StepPipelineContext) throws
}

struct StepPipeline {
    
    let steps: [Step]
    let context: StepPipelineContext
    
    init(steps: [Step], options: Options) {
        self.steps = steps
        let path = Path(options.path).normalize().absolute()
        self.context = StepPipelineContext(verbose: options.verbose, extensions: options.extensions, path: path)
        if context.verbose {
            print("Verbose Logging Enabled.")
        }
    }
    
    func run() -> Result<(), CommandantError<()>> {
        do {
            for step in steps {
                try step.run(context: context)
            }
        } catch {
            return .failure(.usageError(description: error.localizedDescription))
        }
        return .success(())
    }
}
