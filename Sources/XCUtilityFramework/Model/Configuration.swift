//
//  Configuration.swift
//  XCUtilityFramework
//
//  Created by Jeff Lett on 3/10/19.
//

import Foundation

public protocol ConfigurationOptions {
    var config: String { get }
    var extensions: [String] { get }
    var verbose: Bool { get }
    var path: String { get }
    var delete: Bool { get }
}

public struct Configuration {
    public static let fileName = ".xcutility.yml"
    let excluded: [String]
    let extensions: [String]
    let verbose: Bool
    let path: String

    init(excluded: [String], extensions: [String], verbose: Bool, path: String) {
        self.excluded = excluded
        self.verbose = verbose
        self.path = path
        self.extensions = extensions
    }
}

extension Configuration {
    private enum Key: String {
        case excluded
    }

    public init(options: ConfigurationOptions) throws {
        try self.init(configPath: options.config,
                      extensions: options.extensions,
                      verbose: options.verbose,
                      path: options.path)
    }

    init(configPath: String, extensions: [String], verbose: Bool, path: String) throws {
        if verbose {
            print("Loading configuration from '\(configPath)'")
        }
        do {
            let dict = try YamlParser.parse(configPath)
            if verbose {
                print("Loaded configuration successfully.")
            }
            self.init(dict: dict, extensions: extensions, verbose: verbose, path: path)
            return
        } catch YamlParser.YamlParserError.fileNotFound {
            if verbose {
                print("Loading configuration failed.  Using default.")
            }
            self.init(excluded: [],
                      extensions: extensions,
                      verbose: verbose,
                      path: path)
            return
        }
    }

    init(dict: [String: Any], extensions: [String], verbose: Bool, path: String) {
        let excluded = dict[Configuration.Key.excluded.rawValue] as? [String] ?? []
        self.init(excluded: excluded,
                  extensions: extensions,
                  verbose: verbose,
                  path: path)
    }
}
