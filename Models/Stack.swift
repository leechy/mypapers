//
//  Stack.swift
//  mypapers
//
//  Created by Andrey Lechev on 29/09/2025.
//

import Foundation
import SwiftData

@Model
final class Stack {
    var id: String
    var name: String
    var type: StackType
    var papers: [String] = [] // Array of Item IDs
    
    init(id: String, name: String, type: StackType, papers: [String] = []) {
        self.id = id
        self.name = name
        self.type = type
        self.papers = papers
    }
    
    var isSystem: Bool {
        return id == "all_papers"
    }
    
    var displayName: String {
        if isSystem {
            return NSLocalizedString("All Papers", comment: "")
        } else {
            return name
        }
    }
    
    var iconName: String {
        if isSystem {
            return "folder" // Same as folder
        } else {
            return type.iconName
        }
    }
}