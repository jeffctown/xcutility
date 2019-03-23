//
//  FindAllStepFactory.swift
//  XCUtilityFramework
//
//  Created by Jeff Lett on 3/17/19.
//

import Foundation

struct FindAllStepFactory: StepFactory {
    func steps(delete: Bool) -> [Step] {
        var steps: [Step] = [
            FindFiles(),
            FindXcodeProjects(),
            FindXcodeSourceBuildFiles(),
            FindXcodeFiles(),
            FindXcodeReferences(),
            FindUnreferencedFiles(),
            FindUnbuiltFiles()
        ]

        if delete {
            steps.append(DeleteUnreferencedFiles())
            steps.append(DeleteUnbuiltFiles())
        }
        return steps
    }
}
