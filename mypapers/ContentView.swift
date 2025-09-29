//
//  ContentView.swift
//  mypapers
//
//  Created by Andrey Lechev on 29/09/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @Query(sort: \Category.order) private var categories: [Category]
    @State private var selectedCategory: Category?
    @State private var selectedItem: Item?
    @State private var showingAddCategory = false
    private let categoriesManager = CategoriesManager()

    var body: some View {
        NavigationSplitView(sidebar: {
            List(selection: $selectedCategory) {
                Section("categories") {
                    ForEach(categories) { category in
                      Text(category.displayLabel)
                    }
                    .onDelete(perform: { offsets in
                      categoriesManager.deleteCategories(at: offsets, from: categories, modelContext: modelContext)
                    })
                    .onMove(perform: { source, dest in
                      categoriesManager.moveCategories(from: source, to: dest, categories: categories)
                    })
                }
                .sectionActions {
                  Button("add_category", systemImage: "plus.circle") {
                    showingAddCategory = true
                  }
                  .font(.title3)
                }
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
        }, content: {
            if let selectedCategory = selectedCategory {
                List(selection: $selectedItem) {
                    ForEach(items.filter { $0.categories.contains(where: { $0.id == selectedCategory.id }) }) { item in
                        NavigationLink(value: item) {
                            Text(item.title)
                        }
                    }
                }
                .navigationSplitViewColumnWidth(min: 200, ideal: 300)
                .toolbar {
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("add_item", systemImage: "plus")
                        }
                    }
                }
            } else {
                Text("select_a_category")
            }
        }, detail: {
            if let selectedItem = selectedItem {
                Text(String(format: NSLocalizedString("item_detail", comment: ""), selectedItem.title))
            } else {
                Text("select_an_item")
            }
        })
        .sheet(isPresented: $showingAddCategory) {
            AddCategoryView()
        }
        .onAppear {
            categoriesManager.insertSystemCategoriesIfNeeded(categories: categories, modelContext: modelContext)
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date(), localizedTitles: ["en": "New Item"], categories: selectedCategory != nil ? [selectedCategory!] : [])
            modelContext.insert(newItem)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Item.self, Category.self], inMemory: true)
}
