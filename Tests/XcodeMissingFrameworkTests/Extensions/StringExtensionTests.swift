//
//  StringExtensionTests.swift
//  xcodemissingTests
//
//  Created by Jeff Lett on 2/12/19.
//

import Foundation
import XCTest
import XcodeMissingFramework

final class StringExtensionsTests: XCTestCase {
    
    func testXcodeProjectIsDetected() {
        let valid = "/Users/hefe/boom.xcodeproj"
        XCTAssert(valid.containsXcodeProjExtension)
        let validNested = "/Users/hefe/boom.xcodeproj/stuff"
        XCTAssert(validNested.containsXcodeProjExtension)
        let validRelative = "~/SweetApp.xcodeproj"
        XCTAssert(validRelative.containsXcodeProjExtension)
        
        let invalid = "/Users/hefe/nope"
        XCTAssertFalse(invalid.containsXcodeProjExtension)
    }
    
    func testXcodeWorkspaceIsDetected() {
        let valid = "/Users/hefe/boom.xcworkspace"
        XCTAssert(valid.containsXcodeWorkspaceExtension)
        let validNested = "/Users/hefe/boom.xcworkspace/stuff"
        XCTAssert(validNested.containsXcodeWorkspaceExtension)
        let validRelative = "~/SweetApp.xcworkspace"
        XCTAssert(validRelative.containsXcodeWorkspaceExtension)
        
        let invalid = "/Users/hefe/nope"
        XCTAssertFalse(invalid.containsXcodeWorkspaceExtension)
    }
    
    func testXcodeAssetsAreDetected() {
        let valid = "/Users/hefe/boom.xcassets"
        XCTAssert(valid.containsXcodeAssetsExtension)
        let validNested = "/Users/hefe/boom.xcassets/stuff.png"
        XCTAssert(validNested.containsXcodeAssetsExtension)
        let validRelative = "~/SweetApp.xcassets"
        XCTAssert(validRelative.containsXcodeAssetsExtension)
        
        let invalid = "/Users/hefe/nope"
        XCTAssertFalse(invalid.containsXcodeAssetsExtension)
    }
    
    func testPodspecsAreDetected() {
        let valid = "/Users/hefe/SweetPod.podspec"
        XCTAssert(valid.isPodspec)
        let validRelative = "~/SweetPod.podspec"
        XCTAssert(validRelative.isPodspec)
        
        let invalid = "/Users/hefe/nope"
        XCTAssertFalse(invalid.isPodspec)
    }
    
    func testGitignoreIsDetected() {
        let valid = "/Users/hefe/.gitignore"
        XCTAssert(valid.isGitignore)
        let validRelative = "~/.gitignore"
        XCTAssert(validRelative.isGitignore)
        
        let invalid = "/Users/hefe/nope"
        XCTAssertFalse(invalid.isGitignore)
    }
    
    func testDSStoreIsDetected() {
        let valid = "/Users/hefe/.DS_Store"
        XCTAssert(valid.isDSStore)
        let validRelative = "~/.DS_Store"
        XCTAssert(validRelative.isDSStore)
        
        let invalid = "/Users/hefe/nope"
        XCTAssertFalse(invalid.isDSStore)
    }
    
    func testFastlaneIsDetected() {
        let valid = "/Users/hefe/fastlane"
        XCTAssert(valid.containsFastlane)
        let validNested = "/Users/hefe/fastlane/Fastfile"
        XCTAssert(validNested.containsFastlane)
        let validRelative = "~/fastlane"
        XCTAssert(validRelative.containsFastlane)
        
        let invalid = "/Users/hefe/nope"
        XCTAssertFalse(invalid.containsFastlane)
    }
    
    func testCarthageIsDetected() {
        let valid = "/Users/hefe/Carthage"
        XCTAssert(valid.containsCarthage)
        let validNested = "/Users/hefe/Carthage/build/Thing/Thing.framework.zip"
        XCTAssert(validNested.containsCarthage)
        let validRelative = "~/Carthage"
        XCTAssert(validRelative.containsCarthage)
        
        let invalid = "/Users/hefe/nope"
        XCTAssertFalse(invalid.containsCarthage)
    }
    
    
    func testFrameworksAreDetected() {
        let valid = "/Users/hefe/Carthage.framework"
        XCTAssert(valid.containsFrameworkExtension)
        let validNested = "/Users/hefe/Thing.framework/Thing"
        XCTAssert(validNested.containsFrameworkExtension)
        let validRelative = "~/Carthage.framework"
        XCTAssert(validRelative.containsFrameworkExtension)
        
        let invalid = "/Users/hefe/nope"
        XCTAssertFalse(invalid.containsFrameworkExtension)
    }
    
    func testPodfilesAreDetected() {
        let valid = "/Users/hefe/Podfile"
        XCTAssert(valid.containsPodfile)
        let validRelative = "~/Podfile"
        XCTAssert(validRelative.containsPodfile)
        
        let invalid = "/Users/hefe/nope"
        XCTAssertFalse(invalid.containsPodfile)
    }

    func testGemfilesAreDetected() {
        let valid = "/Users/hefe/Gemfile"
        XCTAssert(valid.containsGemfile)
        let validNested = "/Users/hefe/Gemfile.lock"
        XCTAssert(validNested.containsGemfile)
        let validRelative = "~/Gemfile"
        XCTAssert(validRelative.containsGemfile)
        
        let invalid = "/Users/hefe/nope"
        XCTAssertFalse(invalid.containsGemfile)
    }

    func testPlaygroundsAreDetected() {
        let valid = "/Users/hefe/Thing.playground"
        XCTAssert(valid.containsPlaygroundExtension)
        let validNested = "/Users/hefe/Thing.playground/Thing"
        XCTAssert(validNested.containsPlaygroundExtension)
        let validRelative = "~/Carthage.playground"
        XCTAssert(validRelative.containsPlaygroundExtension)
        
        let invalid = "/Users/hefe/nope"
        XCTAssertFalse(invalid.containsPlaygroundExtension)
    }
    
    func testAppCodeIsDetected() {
        let valid = "/Users/hefe/.idea"
        XCTAssert(valid.containsIdeaExtension)
        let validNested = "/Users/hefe/.idea/vcs.xml"
        XCTAssert(validNested.containsIdeaExtension)
        let validRelative = "~/.idea"
        XCTAssert(validRelative.containsIdeaExtension)
        
        let invalid = "/Users/hefe/nope"
        XCTAssertFalse(invalid.containsIdeaExtension)
    }
    
}
