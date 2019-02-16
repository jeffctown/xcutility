//
//  Options.swift
//  xcodemissing
//
//  Created by Jeff Lett on 2/12/19.
//

import Commandant
import Foundation
import Result

struct Options: OptionsProtocol {
    let path: String
    let extensions: [String]
    let verbose: Bool

    static func create(_ path: String) -> ([String]) -> (Bool) -> Options {
        return { extensions in { verbose in Options(path: path, extensions: extensions, verbose: verbose) } }
    }

    static func evaluate(_ mode: CommandMode) -> Result<Options, CommandantError<CommandantError<()>>> {
        let pathDefault = FileManager.default.currentDirectoryPath
        let pathUsage = "the path to search"
        let extensionsUsage = "limit the search to files having specific file extensions"
        let verboseUsage = "enable verbose logging"
        return create
            <*> mode <| Option(key: "path", defaultValue: pathDefault, usage: pathUsage)
            <*> mode <| Option(key: "extensions", defaultValue: [], usage: extensionsUsage)
            <*> mode <| Switch(flag: "v", key: "verbose", usage: verboseUsage)
    }
}
