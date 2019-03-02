//
//  DeleteUnreferencedFiles.swift
//  XCUtilityFramework
//
//  Created by Jeff Lett on 2/12/19.
//

import Foundation

public struct DeleteUnreferencedFiles: Step {
    public init() {}

    public func run(context: PipelineState) throws {
        for unreferencedFile in context.unreferencedFiles.all {
            Log.shared.log("Deleting Unreferenced File: \(unreferencedFile.path.string)")
            try unreferencedFile.path.delete()
        }

        Log.shared.summary("Deleted \(context.unreferencedFiles.all.count) Unreferenced Files")
    }
}
