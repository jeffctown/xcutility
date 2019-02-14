//
//  Path+Extension.swift
//  AEXML
//
//  Created by Jeff Lett on 2/11/19.
//

import Foundation
import PathKit

extension Path {
    public var isXcodeProject: Bool {
        return self.absolute().string.hasSuffix(".xcodeproj")
    }

    public func recursiveFilter(isIncluded: (Path) -> Bool) throws -> [Path] {
        return try self.recursiveChildren().filter(isIncluded)
    }

    public func isValid(context: StepPipelineContext) -> Bool {
        if context.verbose {
            print("Validating File: \(self.string).")
        }
        let isFile = self.isFile
        let staticallyValid = self.isStaticallyValid(context: context)
        let validFileExtension = self.isValidExtension(context: context)
        return isFile && staticallyValid && validFileExtension
    }

    public func isStaticallyValid(context: StepPipelineContext) -> Bool {
        let string = self.string
        // should this go in a file?  .xcodemissingignore or yaml file?
        let staticallyValid = !string.containsPods &&
            !string.containsXcodeProjExtension &&
            !string.containsXcodeWorkspaceExtension &&
            !string.containsXcodeAssetsExtension &&
            !string.isPodspec &&
            !string.isGitignore &&
            !string.isDSStore &&
            !string.containsFastlane &&
            !string.containsGitExtension &&
            !string.containsCarthage &&
            !string.containsFrameworkExtension &&
            !string.containsPodfile &&
            !string.containsGemfile &&
            !string.containsPlaygroundExtension &&
            !string.containsIdeaExtension

        if context.verbose {
            let passedOrFailed = staticallyValid ? "passed" : "failed"
            print("File \(string) \(passedOrFailed) static validation.")
        }

        return staticallyValid
    }

    public func isValidExtension(context: StepPipelineContext) -> Bool {
        let string = self.string
        var isValidExtension = context.extensions.count > 0 ? false : true
        for ext in context.extensions {
            if string.hasSuffix(ext) {
                isValidExtension = true
                if context.verbose {
                    print("Found File \(string) ending in  '\(ext)'.")
                }
            }
        }
        return isValidExtension
    }
}
