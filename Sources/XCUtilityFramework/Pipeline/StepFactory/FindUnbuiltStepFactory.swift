//
//  FindUnbuiltStepFactory.swift
//  XCUtilityFramework
//
//  Created by Jeff Lett on 3/17/19.
//

import Foundation

struct FindUnbuiltStepFactory: StepFactory {
    func steps(delete: Bool) -> [Step] {
        var steps: [Step] = [
            FindXcodeProjects(),
            FindXcodeSourceBuildFiles(),
            FindXcodeFiles(),
            FindUnbuiltFiles()
        ]
        if delete {
            steps.append(DeleteUnbuiltFiles())
        }

        return steps
    }
}
