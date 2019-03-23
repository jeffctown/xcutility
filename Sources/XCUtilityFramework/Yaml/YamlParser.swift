//
//  YamlParser.swift
//  XCUtilityFramework
//
//  Created by Jeff Lett on 3/10/19.
//

import Foundation
import Yams

public struct YamlParser {
    enum YamlParserError: Error {
        case yamlParsing(String)
        case fileNotFound(String)
    }

    public static func parse(_ yamlPath: String) throws -> [String: Any] {
        guard !yamlPath.isEmpty && FileManager.default.fileExists(atPath: yamlPath) else {
            throw YamlParser.YamlParserError.fileNotFound(yamlPath)
        }

        do {
            let yaml = try String(contentsOfFile: yamlPath, encoding: .utf8)
            return try Yams.load(yaml: yaml, .default) as? [String: Any] ?? [:]
        } catch {
            throw YamlParserError.yamlParsing("\(error)")
        }
    }
}
