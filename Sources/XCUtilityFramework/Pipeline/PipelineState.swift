//
//  StepPipelineContext.swift
//  XCUtilityFramework
//
//  Created by Jeff Lett on 2/12/19.
//

import Foundation

public class PipelineState {
    var files = Files()
    var xcodeProjects = [XcodeProject]()
    var unreferencedFiles = Files()
    let config: Configuration

    public init(config: Configuration) {
        self.config = config
    }
}
