//
//  FindUnreferencedFiles.swift
//  XCUtilityFramework
//
//  Created by Jeff Lett on 2/12/19.
//

import Foundation

public struct FindUnreferencedFiles: Step {
    public init() {}

    public func run(context: PipelineState) {
        context.unreferencedFiles = Files(array: context.files.all.filter { !$0.hasProjectReferences })
        Log.shared.header("Unreferenced Files")

        for unreferencedFile in context.unreferencedFiles.all.sorted() {
            Log.shared.log(unreferencedFile.path.string)
        }

        Log.shared.summary("Total \(context.unreferencedFiles.all.count) Unreferenced Files")
    }
}
