//
//  String+Extension.swift
//  XCUtilityFramework
//
//  Created by Jeff Lett on 2/12/19.
//

import Foundation
import PathKit

public extension String {
    var path: Path {
        return Path(self)
    }
}
