//
//  XcodeProject.swift
//  XCUtilityFramework
//
//  Created by Jeff Lett on 3/10/19.
//

import Foundation
import PathKit
import xcodeproj

class XcodeProject: CustomStringConvertible {
    private let xcodeProj: XcodeProj
    private let path: Path
    private let directory: Path
    var files: [XcodeFile]
    var sourceBuildFiles: [String]
    var unbuiltFiles: [XcodeFile]

    init?(path: String) {
        do {
            self.path = Path(path)
            self.xcodeProj = try XcodeProj(path: self.path)
            self.sourceBuildFiles = [String]()
            self.unbuiltFiles = [XcodeFile]()
            self.files = [XcodeFile]()
            self.directory = Path(self.path.string.replacingOccurrences(of: self.path.lastComponent, with: ""))
        } catch {
            Log.shared.log("\(path) : \(error.localizedDescription)")
            return nil
        }
    }

    func loadFiles(context: PipelineState) {
        for xcodeFileReference in xcodeProj.pbxproj.fileReferences {
            do {
                if let path = try xcodeFileReference.fullPath(sourceRoot: directory),
                    Path(path.string).isValid(context: context) {
                    if context.config.verbose {
                        Log.shared.log("Found Xcode File: \(path)")
                    }

                    files.append(XcodeFile(fileReference: xcodeFileReference, path: path))
                }
            } catch {
                Log.shared.log(error.localizedDescription)
            }
        }
    }

    func loadSourceBuildFiles(context: PipelineState) {
        for sourceBuildPhase in xcodeProj.pbxproj.sourcesBuildPhases {
            for fileReference in sourceBuildPhase.files {
                do {
                    if let file = fileReference.file,
                        let fullPath = try file.fullPath(sourceRoot: directory) {
                        sourceBuildFiles.append(fullPath.string)
                    }
                } catch {
                    Log.shared.log(error.localizedDescription)
                }
            }
        }
    }

    func remove(sourceBuildfile: PBXFileReference) {
        self.xcodeProj.pbxproj.delete(object: sourceBuildfile)
    }

    func save() throws {
        let path = Path(self.path.string + "/project.pbxproj")
        try self.xcodeProj.pbxproj.write(path: path, override: true)
    }

    // MARK: - Protocol CustomStringConvertible
    var description: String {
        return "\(self.path.string) \(self.files.count) files \(self.sourceBuildFiles.count) source build files"
    }
}
