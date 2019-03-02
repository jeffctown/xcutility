//
//  StepPipelineContext.swift
//  XcodeMissingFramework
//
//  Created by Jeff Lett on 2/12/19.
//

import Foundation
import PathKit
import xcodeproj

public class StepPipelineContext {
    let verbose: Bool
    let extensions: [String]
    let path: Path
    var files = Files()
    var xcodeProjects = [XcodeProj]()
    var unusedFiles = Files()
    var missingFiles = Files()

    public init(verbose: Bool, extensions: [String], path: String) {
        self.verbose = verbose
        self.extensions = extensions
        self.path = Path(path).absolute().normalize()
    }
}
