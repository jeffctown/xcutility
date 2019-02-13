//
//  String+Extension.swift
//  xcodemissing
//
//  Created by Jeff Lett on 2/12/19.
//

import Foundation

extension String {
    
    var containsXcodeProjExtension: Bool { return self.contains(".xcodeproj") }
    var containsXcodeWorkspaceExtension: Bool { return self.contains(".xcworkspace") }
    var containsXcodeAssetsExtension: Bool { return self.contains(".xcassets") }
    var containsPods: Bool { return self.contains("Pods") }
    var containsFastlane: Bool { return self.contains("fastlane") }
    var containsGitExtension: Bool { return self.contains(".git") }
    var containsCarthage: Bool { return self.contains("Carthage") }
    var containsFrameworkExtension: Bool { return self.contains(".framework") }
    var containsPlaygroundExtension: Bool { return self.contains(".playground") } 
    var containsPodfile: Bool { return self.contains("Podfile") }
    var containsGemfile: Bool { return self.contains("Gemfile") }
    var containsIdeaExtension: Bool { return self.contains(".idea") }
    
    var isPodspec: Bool { return self.hasSuffix(".podspec") }
    var isGitignore: Bool { return self.hasSuffix(".gitignore") }
    var isDSStore: Bool { return self.hasSuffix(".DS_Store") }

}
