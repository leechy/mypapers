//
//  Item.swift
//  mypapers
//
//  Created by Andrey Lechev on 29/09/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var id: String
    var timestamp: Date
    var localizedTitles: [String: String] // key: language code (e.g., "en", "es"), value: title in that language
    @Relationship var categories: [Category] = []
    
    init(id: String = UUID().uuidString, timestamp: Date, localizedTitles: [String: String] = [:], categories: [Category] = []) {
        self.id = id
        self.timestamp = timestamp
        self.localizedTitles = localizedTitles
        self.categories = categories
    }
    
    var title: String {
        let languageCode = Locale.current.language.languageCode?.identifier ?? "en"
        return localizedTitles[languageCode] ?? localizedTitles["en"] ?? "Untitled"
    }
}
