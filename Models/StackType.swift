//
//  StackType.swift
//  mypapers
//
//  Created by Andrey Lechev on 29/09/2025.
//

import Foundation

enum StackType: String, Codable {
    case folder
    case project
    case collection
    case trip
    
    var iconName: String {
        switch self {
        case .folder:
            return "folder"
        case .project:
            return "case"
        case .collection:
            return "rectangle.stack"
        case .trip:
            return "airplane.ticket"
        }
    }
    
    var displayName: String {
        switch self {
        case .folder:
            return NSLocalizedString("Folder", comment: "")
        case .project:
            return NSLocalizedString("Project", comment: "")
        case .collection:
            return NSLocalizedString("Collection", comment: "")
        case .trip:
            return NSLocalizedString("Trip", comment: "")
        }
    }
}
