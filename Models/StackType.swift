//
//  StackType.swift
//  mypapers
//
//  Created by Andrey Lechev on 29/09/2025.
//

import Foundation

enum StackType: String, Codable {
  case project
  case collection
  case trip
  case folder

  var iconName: String {
    switch self {
    case .project:
      return "case"
    case .collection:
      return "rectangle.stack"
    case .trip:
      return "airplane.ticket"
    case .folder:
      return "folder"
    }
  }
    
  var displayName: String {
    switch self {
    case .project:
      return NSLocalizedString("Project", comment: "")
    case .collection:
      return NSLocalizedString("Collection", comment: "")
    case .trip:
      return NSLocalizedString("Trip", comment: "")
    case .folder:
      return NSLocalizedString("Folder", comment: "")
    }
  }
}
