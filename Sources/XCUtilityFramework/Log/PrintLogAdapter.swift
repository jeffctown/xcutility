//
//  PrintLogAdapter.swift
//  XCUtilityFramework
//
//  Created by Jeff Lett on 3/10/19.
//

import Foundation

struct PrintLogAdapter: LogAdapter {
    func log(_ item: Any) {
        print(item)
    }
}
