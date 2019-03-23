//
//  Path+Extension.swift
//  XCUtilityFramework
//
//  Created by Jeff Lett on 2/11/19.
//

import Foundation
import PathKit

public extension Path {
    var isXcodeProject: Bool {
        return self.absolute().string.hasSuffix(".xcodeproj")
    }

    func recursiveFilter(isIncluded: (Path) -> Bool) throws -> [Path] {
        return try self.recursiveChildren().filter(isIncluded)
    }

    func isValid(context: PipelineState) -> Bool {
        let isFile = self.isFile
        let isValidPath = self.isValid(config: context.config)
        let isValidFileExtension = self.isValidExtension(context: context)
        return isFile && isValidPath && isValidFileExtension
    }

    func isValid(config: Configuration) -> Bool {
        for excluded in config.excluded {
            if self.string.contains(excluded) {
                return false
            }
        }
        return true
    }

    func isValidExtension(context: PipelineState) -> Bool {
        let string = self.string
        var isValidExtension = context.config.extensions.isEmpty ? true : false
        for ext in context.config.extensions {
            if string.hasSuffix(ext) {
                isValidExtension = true
            }
        }
        return isValidExtension
    }
}
