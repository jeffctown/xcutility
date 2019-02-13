//
//  String+Extension.swift
//  xcodemissing
//
//  Created by Jeff Lett on 2/12/19.
//

import Foundation

extension String {
    
    public var containsXcodeProjExtension: Bool { return self.contains(".xcodeproj") }
    public var containsXcodeWorkspaceExtension: Bool { return self.contains(".xcworkspace") }
    public var containsXcodeAssetsExtension: Bool { return self.contains(".xcassets") }
    public var containsPods: Bool { return self.contains("Pods") }
    public var containsFastlane: Bool { return self.contains("fastlane") }
    public var containsGitExtension: Bool { return self.contains(".git") }
    public var containsCarthage: Bool { return self.contains("Carthage") }
    public var containsFrameworkExtension: Bool { return self.contains(".framework") }
    public var containsPlaygroundExtension: Bool { return self.contains(".playground") }
    public var containsPodfile: Bool { return self.contains("Podfile") }
    public var containsGemfile: Bool { return self.contains("Gemfile") }
    public var containsIdeaExtension: Bool { return self.contains(".idea") }
    
    public var isPodspec: Bool { return self.hasSuffix(".podspec") }
    public var isGitignore: Bool { return self.hasSuffix(".gitignore") }
    public var isDSStore: Bool { return self.hasSuffix(".DS_Store") }

}
