//
//  FindXcodeFiles.swift
//  XCUtilityFramework
//
//  Created by Jeff Lett on 2/12/19.
//

import Foundation

public struct FindXcodeFiles: Step {
    public init() {}

    public func run(context: PipelineState) throws {
        context.xcodeProjects = context.xcodeProjects.map {
            $0.loadFiles(context: context)
            return $0
        }
    }
}
