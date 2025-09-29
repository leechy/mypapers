//
//  CategoriesManager.swift
//  mypapers
//
//  Created by Andrey Lechev on 29/09/2025.
//

import SwiftUI
import SwiftData

class CategoriesManager {
    
    func insertSystemCategoriesIfNeeded(categories: [Category], modelContext: ModelContext) {
        let systemCategories = [
            ("medical", "Medical"),
            ("household", "Household"),
            ("education", "Education"),
            ("sport", "Sport"),
            ("vehicle", "Vehicle"),
            ("cards", "Plastic Cards"),
            ("communication", "Communication"),
            ("income", "Income / Payslips"),
            ("contracts", "Contracts"),
            ("taxes", "Taxes"),
            ("work", "Work"),
            ("ids_passports", "IDs and Passports"),
            ("food", "Food"),
            ("other", "Other")
        ]
        
        for (index, (id, label)) in systemCategories.enumerated() {
            if !categories.contains(where: { $0.id == id }) {
                let category = Category(id: id, label: label, system: true, order: index)
                modelContext.insert(category)
            }
        }
    }
    
    func deleteCategories(at offsets: IndexSet, from categories: [Category], modelContext: ModelContext) {
        withAnimation {
            for index in offsets {
                if !categories[index].system {
                    modelContext.delete(categories[index])
                }
            }
        }
    }
    
    func moveCategories(from source: IndexSet, to destination: Int, categories: [Category]) {
        var reordered = Array(categories)
        reordered.move(fromOffsets: source, toOffset: destination)
        for (index, category) in reordered.enumerated() {
            category.order = index
        }
    }
}
