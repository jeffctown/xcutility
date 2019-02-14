//
//  FileGatherStepTests.swift
//  XcodeMissingFrameworkTests
//
//  Created by Jeff Lett on 2/13/19.
//

import Foundation
@testable import XcodeMissingFramework
import XCTest
import PathKit

final class FileGatherStepTests: XCTestCase {
    
    let folderPath = NSTemporaryDirectory() + "FileGatherTests"
    var path: Path!
    
    override func setUp() {
        super.setUp()
        path = Path(folderPath)
        let folderURL = URL(fileURLWithPath: folderPath)
        
        try? FileManager.default.removeItem(at: folderURL)
        try! FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true)
        FileManager.default.createFile(atPath: folderPath + "/File.swift", contents: nil)
        FileManager.default.createFile(atPath: folderPath + "/AnotherFile.h", contents: nil)
        FileManager.default.createFile(atPath: folderPath + "/AnotherFile.m", contents: nil)
        FileManager.default.createFile(atPath: folderPath + "/AnotherFile.txt", contents: nil)
    }
    
    func testExceptionIsThrownWithBadPath() {
        let path = Path("khadsdhh")
        let context = StepPipelineContext(verbose: false, extensions: [], path: path)
        do {
            try FileGatherStep().run(context: context)
            XCTFail("Exception should be thrown for a bad path.")
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func testAllFilesAreGatheredWithNoExtensions() {
        let context = StepPipelineContext(verbose: false, extensions: [], path: path)
        do {
            try FileGatherStep().run(context: context)
            XCTAssertEqual(context.files.keys.count, 4)
        } catch {
            XCTFail("Should not throw.")
        }
    }
    
    func testAllFilesAreGatheredWhenVerbose() {
        let context = StepPipelineContext(verbose: true, extensions: [], path: path)
        do {
            try FileGatherStep().run(context: context)
            XCTAssertEqual(context.files.keys.count, 4)
            for file in context.files.keys {
                XCTAssertEqual(context.files[file], 0)
            }
        } catch {
            XCTFail("Should not throw.")
        }
    }
    
    func testAllFilesAreGatheredWhenOneExtensionIsUsed() {
        let context = StepPipelineContext(verbose: false, extensions: [".swift"], path: path)
        do {
            try FileGatherStep().run(context: context)
            XCTAssertEqual(context.files.keys.count, 1)
            for file in context.files.keys {
                XCTAssertEqual(context.files[file], 0)
            }
        } catch {
            XCTFail("Should not throw.")
        }
    }
    
    func testAllFilesAreGatheredWhenMultipleExtensionsAreUsed() {
        let context = StepPipelineContext(verbose: false, extensions: [".swift",".h",".m"], path: path)
        do {
            try FileGatherStep().run(context: context)
            XCTAssertEqual(context.files.keys.count, 3)
            for file in context.files.keys {
                XCTAssertEqual(context.files[file], 0)
            }
        } catch {
            XCTFail("Should not throw.")
        }
    }
    
    
}

