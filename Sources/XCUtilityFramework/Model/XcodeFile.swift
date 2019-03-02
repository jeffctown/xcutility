//
//  XcodeFile.swift
//  XCUtilityFramework
//
//  Created by Jeff Lett on 3/10/19.
//

import Foundation
import PathKit
import xcodeproj

struct XcodeFile {
    let fileReference: PBXFileReference?
    let path: Path
}
