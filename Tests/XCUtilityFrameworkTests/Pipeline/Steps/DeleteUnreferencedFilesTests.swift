//
//  DeleteUnreferencedFilesTests.swift
//  XCUtilityFrameworkTests
//
//  Created by Jeff Lett on 2/13/19.
//

import XCTest
@testable import XCUtilityFramework

// swiftlint:disable implicitly_unwrapped_optional force_try
class DeleteUnreferencedFilesTests: XCTestCase {
    let folderPath = NSTemporaryDirectory() + "DeleteFileTests"
    var swiftFilePath: String!
    var objCHeaderPath: String!
    var objCImplPath: String!
    var otherFilePath: String!

    override func setUp() {
        super.setUp()
        let folderURL = URL(fileURLWithPath: folderPath)
        swiftFilePath = folderPath + "/File.swift"
        objCHeaderPath = folderPath + "/AnotherFile.h"
        objCImplPath = folderPath + "/AnotherFile.m"
        otherFilePath = folderPath + "/AnotherFile.txt"

        try? FileManager.default.removeItem(at: folderURL)
        try! FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true)
        FileManager.default.createFile(atPath: swiftFilePath, contents: nil)
        FileManager.default.createFile(atPath: objCHeaderPath, contents: nil)
        FileManager.default.createFile(atPath: objCImplPath, contents: nil)
        FileManager.default.createFile(atPath: otherFilePath, contents: nil)
    }

    func testOnlyUnreferencedFilesAreDeleted() {
        let config = Configuration(excluded: [],
                                   extensions: [],
                                   verbose: false,
                                   path: folderPath)
        let context = PipelineState(config: config)
        context.unreferencedFiles.add(File(filename: swiftFilePath))
        context.unreferencedFiles.add(File(filename: objCHeaderPath))
        context.unreferencedFiles.add(File(filename: objCImplPath))
        
        try! DeleteUnreferencedFiles().run(context: context)
        XCTAssertFalse(FileManager.default.fileExists(atPath: swiftFilePath))
        XCTAssertFalse(FileManager.default.fileExists(atPath: objCHeaderPath))
        XCTAssertFalse(FileManager.default.fileExists(atPath: objCImplPath))
        XCTAssertTrue(FileManager.default.fileExists(atPath: otherFilePath))
    }
}
