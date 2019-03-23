//
//  DeleteUnbuiltFiles.swift
//  XCUtilityFramework
//
//  Created by Jeff Lett on 3/9/19.
//

import Foundation

public struct DeleteUnbuiltFiles: Step {
    public init() {}

    public func run(context: PipelineState) throws {
        var count = 0
        for xcodeProject in context.xcodeProjects {
            for unbuiltFile in xcodeProject.unbuiltFiles {
                Log.shared.log("Deleting Unbuilt File: \(unbuiltFile.path.string)")
                if let fileReference = unbuiltFile.fileReference {
                    xcodeProject.remove(sourceBuildfile: fileReference)
                    try unbuiltFile.path.delete()
                    count += 1
                }
                try xcodeProject.save()
            }
        }

        Log.shared.summary("Deleted \(count) Unbuilt Files")
    }
}
