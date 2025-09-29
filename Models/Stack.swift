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
  var order: Int
  var papers: [String] = [] // Array of Item IDs
    
  init(id: String, name: String, type: StackType, papers: [String] = [], order: Int) {
    self.id = id
    self.name = name
    self.type = type
    self.papers = papers
    self.order = order
  }
    
  var iconName: String {
    return type.iconName
  }
}
