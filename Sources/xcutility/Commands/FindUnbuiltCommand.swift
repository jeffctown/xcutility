//
//  FindUnbuilt.swift
//  xcutility
//
//  Created by Jeff Lett on 3/8/19.
//

import Commandant
import Foundation
import Result
import XCUtilityFramework

struct FindUnbuiltCommand: CommandProtocol, CommandProvider {
    // MARK: - CommandProvider

    let command: AbstractStepFactory.Command = .findUnbuilt

    func beginMessage(path: String) -> String {
        return "Finding unbuilt files in: \(path)"
    }

    // MARK: - CommandProtocol

    let verb = "unbuilt"
    let function = "Find files that are referenced in Xcode but not built in any build phases"

    // MARK: - OptionsProtocol

    struct Options: OptionsProtocol, ConfigurationOptions {
        let path: String
        let extensions: [String]
        let verbose: Bool
        let delete: Bool
        let config: String

        static func create(_ path: String) -> ([String]) -> (Bool) -> (Bool) -> (String) -> Options {
            return { extensions in { verbose in { delete in { config in Options(path: path,
                                                                                extensions: extensions,
                                                                                verbose: verbose,
                                                                                delete: delete,
                                                                                config: config) } } } }
        }

        static func evaluate(_ mode: CommandMode) -> Result<Options, CommandantError<CommandantError<()>>> {
            return create
                <*> mode <| optionPath
                <*> mode <| optionExtensions
                <*> mode <| switchVerbose
                <*> mode <| switchDelete
                <*> mode <| optionConfig
        }
    }
}
