//
//  FindXcodeProjects.swift
//  XCUtilityFramework
//
//  Created by Jeff Lett on 3/2/19.
//

import Foundation

public struct FindXcodeProjects: Step {
    public init() {}

    public func run(context: PipelineState) throws {
        let xcodeProjectPaths = try context.config.path.path.recursiveFilter {
            $0.isXcodeProject && $0.isValid(config: context.config)
        }
        for xcodeProjectPath in xcodeProjectPaths {
            if context.config.verbose {
                Log.shared.log("Found Xcode Project: \(xcodeProjectPath)")
            }

            guard let xcodeProject = XcodeProject(path: xcodeProjectPath.string) else {
                continue
            }

            context.xcodeProjects.append(xcodeProject)
        }
    }
}
