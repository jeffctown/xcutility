//
//  FindXcodeReferences.swift
//  XCUtilityFramework
//
//  Created by Jeff Lett on 3/2/19.
//

import Foundation

public struct FindXcodeReferences: Step {
    public init() {}

    public func run(context: PipelineState) throws {
        for xcodeProject in context.xcodeProjects {
            for xcodeFile in xcodeProject.files {
                if context.config.verbose {
                    Log.shared.log("  Found Xcode File Reference: \(xcodeFile)")
                }

                if var file = context.files.file(for: xcodeFile.path) {
                    file.incrementReferenceCount()
                    context.files.add(file)
                    if context.config.verbose {
                        Log.shared.log("     Incremented Reference Count: \(file)")
                    }
                }
            }
        }
    }
}
