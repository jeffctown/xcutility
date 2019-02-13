//
//  Options.swift
//  xcodemissing
//
//  Created by Jeff Lett on 2/12/19.
//

import Foundation
import Commandant
import Result

public struct Options: OptionsProtocol {
    let path: String
    let extensions: [String]
    let verbose: Bool
    
    static func create(_ path: String) -> ([String]) -> (Bool) -> Options {
        return { extensions in { verbose in Options(path: path, extensions: extensions, verbose: verbose) } }
    }
    
    public static func evaluate(_ m: CommandMode) -> Result<Options, CommandantError<CommandantError<()>>> {
        return create
            <*> m <| Option(key: "path", defaultValue: FileManager.default.currentDirectoryPath, usage: "the path to search")
            <*> m <| Option(key: "extensions", defaultValue: [], usage: "limit the search to files having specific file extensions")
            <*> m <| Switch(flag: "v", key: "verbose", usage: "enable verbose logging")
    }
}
