//
//  XcodeReferenceGatherStep.swift
//  XcodeMissingFramework
//
//  Created by Jeff Lett on 2/12/19.
//

import Foundation
import PathKit
import xcodeproj

public struct XcodeReferenceGatherStep: Step {
    public init() {}

    public func run(context: StepPipelineContext) throws {
        let xcodeProjectPaths = try context.path.recursiveFilter { $0.isXcodeProject }
        for xcodeProjectPath in xcodeProjectPaths {
            do {
                if context.verbose {
                    print("Examining \(xcodeProjectPath)")
                }
                let xcodeProj = try XcodeProj(path: xcodeProjectPath)
                context.xcodeProjects.append(xcodeProj)
                let last = xcodeProjectPath.lastComponent
                let projectPathString = xcodeProjectPath.string.replacingOccurrences(of: last, with: "")
                let projectPath = Path(projectPathString)
                let xcodeFiles = xcodeProj.pbxproj.fileReferences
                    .compactMap { try? $0.fullPath(sourceRoot: projectPath)?.string }
                for xcodeFile in xcodeFiles {
                    if context.verbose {
                        print("  Found Xcode File Reference: \(xcodeFile)")
                    }
                    if var file = context.files.file(for: xcodeFile) {
                        file.incrementReferenceCount()
                        context.files.add(file)
                    }
                }
            } catch {
                print("Error Opening Xcode Project: \(xcodeProjectPath) \(error)")
            }
        }
    }
}
