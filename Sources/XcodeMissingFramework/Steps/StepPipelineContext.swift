//
//  StepPipelineContext.swift
//  xcodemissing
//
//  Created by Jeff Lett on 2/12/19.
//

import Foundation
import xcodeproj
import PathKit

public class StepPipelineContext {
    let verbose: Bool
    let extensions: [String]
    let path: Path
    var files = [String: Int]()
    var xcodeProjects = [XcodeProj]()
    var unusedFiles = [String]()

    public init(verbose: Bool, extensions: [String], path: String) {
        self.verbose = verbose
        self.extensions = extensions
        self.path = Path(path).absolute().normalize()
    }
}
