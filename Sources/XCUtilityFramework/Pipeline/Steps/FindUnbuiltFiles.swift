//
//  FindUnbuiltFiles.swift
//  XCUtilityFramework
//
//  Created by Jeff Lett on 3/2/19.
//

import Foundation

public struct FindUnbuiltFiles: Step {
    public init() {}

    public func run(context: PipelineState) throws {
        Log.shared.header("Unbuilt Files")

        var count = 0
        for xcodeProject in context.xcodeProjects {
            for xcodeFile in xcodeProject.files {
                guard !xcodeFile.path.string.hasSuffix(".h") else {
                    continue
                }

                if !xcodeProject.sourceBuildFiles.contains(xcodeFile.path.string) {
                    if xcodeProject.unbuiltFiles.isEmpty {
                        Log.shared.log(xcodeProject)
                    }
                    xcodeProject.unbuiltFiles.append(xcodeFile)
                    Log.shared.log("  \(xcodeFile.path.string)")
                }
            }
            count += xcodeProject.unbuiltFiles.count
        }

        Log.shared.summary("Total \(count) Unbuilt Files")
    }
}
