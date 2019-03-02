//
//  FindFiles.swift
//  XCUtilityFramework
//
//  Created by Jeff Lett on 2/12/19.
//

import Foundation

public struct FindFiles: Step {
    public init() {}

    public func run(context: PipelineState) throws {
        let files = try context.config.path.path.recursiveFilter { $0.isValid(context: context) }
        for file in files {
            if context.config.verbose {
                Log.shared.log("Found File: \(file.string)")
            }
            context.files.add(File(path: file.absolute()))
        }
    }
}
