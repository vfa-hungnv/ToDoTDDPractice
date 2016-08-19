//
//  ToDoItem.swift
//  ToDoTDD
//
//  Created by Hung Nguyen on 8/12/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import Foundation

struct ToDoItem {
    // Test push
    let title: String
    let itemDescription: String?
    let timestamp: Double?
    let location: Location?
    
    init(title: String, itemDescription: String? = nil, timestamp: Double? = nil, location: Location? = nil) {
        self.title = title
        self.itemDescription = itemDescription
        self.timestamp = timestamp
        self.location = location
    }
}

extension ToDoItem: Equatable {}

func ==(lhs: ToDoItem, rhs: ToDoItem) -> Bool {
    if lhs.location != rhs.location {
        return false
    }
    
    if lhs.timestamp != rhs.timestamp {
        return false
    }
    
    if lhs.itemDescription != rhs.itemDescription {
        return false
    }
    
    if lhs.title != rhs.title {
        return false
    }
    
    
    return true
}
