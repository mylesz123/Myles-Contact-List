//
//  File.swift
//  Myles Contact List
//
//  Created by Myles Young on 11/5/19.
//  Copyright © 2019 Myles Young. All rights reserved.
//

/*
 This declares a struct that contains the two keys as static strings that are globally available. A struct in Swift works in many ways like a class, in that you can declare methods in a struct, but because structs are always copied and passed as values rather than as references, they are particularly well suited to simple data structures that contain scalar values.
 */

import Foundation

struct Constants {
    static let kSortField = "sortField"
    static let kSortDirection = "sortDirectionAscending"
}
