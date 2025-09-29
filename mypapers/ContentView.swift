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
    @Query private var stacks: [Stack]
    @State private var selectedStack: Stack?
    @State private var selectedItem: Item?
    @State private var showingAddCategory = false
    private let categoriesManager = CategoriesManager()
    private let stacksManager = StacksManager()

    var body: some View {
        NavigationSplitView(sidebar: {
            List(selection: $selectedStack) {
                Section("stacks") {
                    ForEach(stacks) { stack in
                        Label(stack.displayName, systemImage: stack.iconName)
                    }
                    .onDelete(perform: { offsets in stacksManager.deleteStacks(at: offsets, from: stacks, modelContext: modelContext) })
                    .onMove(perform: { source, dest in stacksManager.moveStacks(from: source, to: dest, stacks: stacks) })
                }
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            .toolbar {
                ToolbarItem {
                    Button(action: { showingAddCategory = true }) {
                        Label("add_stack", systemImage: "plus")
                    }
                }
            }
        }, content: {
            if let selectedStack = selectedStack {
                List(selection: $selectedItem) {
                    ForEach(items.filter { selectedStack.id == "all_papers" || selectedStack.papers.contains($0.id) }) { item in
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
                Text("select_a_stack")
            }
        }, detail: {
            if let selectedItem = selectedItem {
                Text(String(format: NSLocalizedString("item_detail", comment: ""), selectedItem.title))
            } else {
                Text("select_an_item")
            }
        })
        .sheet(isPresented: $showingAddCategory) {
            AddStackView()
        }
        .onAppear {
            categoriesManager.insertSystemCategoriesIfNeeded(categories: [], modelContext: modelContext) // Keep categories for now
            stacksManager.insertSystemStacksIfNeeded(stacks: stacks, modelContext: modelContext)
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date(), localizedTitles: ["en": "New Item"], categories: [])
            modelContext.insert(newItem)
            if let selectedStack = selectedStack, selectedStack.id != "all_papers" {
                stacksManager.addPaperToStack(stack: selectedStack, paperId: newItem.id)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Item.self, Category.self, Stack.self], inMemory: true)
}
