//
//  CategoriesListView.swift
//  mypapers
//
//  Created by Andrey Lechev on 01/10/2025.
//

import SwiftUI
import SwiftData

struct CategoriesListView: View {
  @Environment(\.modelContext) private var modelContext

  @Binding var showingAddCategory: Bool

  private let categoriesManager = CategoriesManager()
  @Query(sort: \Category.order) private var categories: [Category]

  @State private var categoriesExpanded = true
  
  @State private var editingCategory: Category? = nil
  @State private var editedCategoryName = ""
  @FocusState private var isEditingFocused: Bool
  
  var body: some View {
    Section("categories", isExpanded: $categoriesExpanded) {
      ForEach(categories, id: \.prefixedID) { category in
        if editingCategory?.id == category.id {
          HStack {
            Image(systemName: "folder")
            TextField("", text: $editedCategoryName)
              .focused($isEditingFocused)
              .onSubmit(commitRename)
              .onKeyPress(.escape) {
                cancelRename()
                return .handled
              }
              .onChange(of: isEditingFocused) {
                if !isEditingFocused {
                  cancelRename()
                }
              }
              .onAppear {
                editedCategoryName = category.label
                isEditingFocused = true
              }
          }
        } else {
          NavigationLink(value: category.displayLabel) {
            Label(category.displayLabel, systemImage: "folder")
          }
          .contextMenu {
            Section {
              Button {
                showingAddCategory = true
              } label: {
                Label("New Category", systemImage: "folder.badge.plus")
              }
            }
            if !category.system {
              Section {
                Button {
                  startRenaming(category)
                } label: {
                  Label("Rename Category", systemImage: "pencil")
                }
                Button(role: .destructive) {
                  categoriesManager.deleteCategory(category, modelContext: modelContext)
                } label: {
                  Label("Delete Category", systemImage: "trash")
                }
              }
            }
          }
        }
      }
      .onDelete(perform: { offsets in
        categoriesManager.deleteCategories(
          at: offsets, from: categories,
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
    .onAppear {
      categoriesManager.insertSystemCategoriesIfNeeded(categories: categories, modelContext: modelContext)
    }
  }
  
  private func startRenaming(_ category: Category) {
    editingCategory = category
    editedCategoryName = category.label
  }
  
  private func commitRename() {
    if let category = editingCategory, !editedCategoryName.isEmpty {
      categoriesManager.renameCategory(category, to: editedCategoryName, modelContext: modelContext)
    }
    editingCategory = nil
    editedCategoryName = ""
  }
  
  private func cancelRename() {
    editingCategory = nil
    editedCategoryName = ""
  }
}

#Preview {
  List {
    CategoriesListView(showingAddCategory: .constant(false))
  }
  .modelContainer(for: [Category.self], inMemory: true)
}

