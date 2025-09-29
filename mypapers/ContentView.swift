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

  private let categoriesManager = CategoriesManager()
  private let stacksManager = StacksManager()

  @Query(sort: \Stack.order) private var stacks: [Stack]
  @State private var selectedStack: Stack? = nil

  @Query(sort: \Category.order) private var categories: [Category]
  @State private var selectedCategory: Category? = nil

  @State private var showingAddStack = false
  @State private var showingAddCategory = false

  var body: some View {
    NavigationSplitView(sidebar: {
      List(selection: $selectedStack) {
        Label(String(format: NSLocalizedString("all_papers", comment: "")), systemImage: "rectangle.grid.2x2")

        Section("stacks") {
          ForEach(stacks) { stack in
            Label(stack.name, systemImage: stack.iconName)
          }
          .onDelete(perform: { offsets in
            stacksManager.deleteStacks(
              at: offsets,
              from: stacks,
              modelContext: modelContext
            )
          })
          .onMove(perform: { source, dest in
            stacksManager.moveStacks(
              from: source,
              to: dest,
              stacks: stacks
            )
          })
        }
        .sectionActions {
          Button(action: { showingAddStack = true }) {
            Label("add_stack", systemImage: "plus.circle")
              .font(.title3)
          }
        }

        Section("categories") {
          ForEach(categories) { category in
            Label(category.displayLabel, systemImage: "folder")
          }
          .onDelete(perform: { offsets in
            categoriesManager.deleteCategories(
              at: offsets, from: stacks as! [Category],
              modelContext: modelContext
            )
          })
          .onMove(perform: { source, dest in
            categoriesManager.moveCategories(
              from: source,
              to: dest,
              categories: categories
            )
          })
        }
        .sectionActions {
          Button(action: { showingAddCategory = true }) {
            Label("add_category", systemImage: "plus.circle")
              .font(.title3)

          }
        }
      }
      .navigationSplitViewColumnWidth(min: 180, ideal: 200)

    }, content: {
      if selectedStack != nil {
            List {
              ForEach(items) { item in
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
          Text("select_an_item")
        })
        .sheet(isPresented: $showingAddStack) {
          AddStackView()
        }
        .sheet(isPresented: $showingAddCategory) {
          AddCategoryView()
        }
        .onAppear {
            categoriesManager.insertSystemCategoriesIfNeeded(categories: [], modelContext: modelContext) // Keep categories for now
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date(), localizedTitles: ["en": "New Item"], categories: [])
            modelContext.insert(newItem)
          if selectedStack != nil {
            stacksManager.addPaperToStack(stack: selectedStack!, paperId: newItem.id)
          }
        }
    }
}

#Preview {
  ContentView()
    .modelContainer(for: [Item.self, Category.self, Stack.self], inMemory: true)
}
