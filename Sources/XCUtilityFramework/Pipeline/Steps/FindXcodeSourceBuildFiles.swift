//
//  GatherXcodeSourceBuildFiles.swift
//  XCUtilityFramework
//
//  Created by Jeff Lett on 3/2/19.
//

import Foundation

public struct FindXcodeSourceBuildFiles: Step {
    public init() {}

    public func run(context: PipelineState) throws {
        for xcodeProject in context.xcodeProjects {
            xcodeProject.loadSourceBuildFiles(context: context)
        }
    }
}
