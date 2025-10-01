//
//  Category.swift
//  mypapers
//
//  Created by Andrey Lechev on 29/09/2025.
//

import Foundation
import SwiftData

@Model
final class Category {
    var id: String
    var label: String
    var system: Bool
    var order: Int
    
    init(id: String, label: String, system: Bool, order: Int) {
        self.id = id
        self.label = label
        self.system = system
        self.order = order
    }
    
    // Computed property for localized label if system
    var displayLabel: String {
        if system {
            return String(format: NSLocalizedString(label, comment: ""))
        } else {
            return label
        }
    }

  var prefixedID: String {
    return "category_\(id)"
  }
}
