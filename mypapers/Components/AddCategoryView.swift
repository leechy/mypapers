//
//  AddCategoryView.swift
//  mypapers
//
//  Created by Andrey Lechev on 29/09/2025.
//

import SwiftUI
import SwiftData

struct AddCategoryView: View {
  @Environment(\.dismiss) private var dismiss
  @Environment(\.modelContext) private var modelContext
  @Query(sort: \Category.order) private var categories: [Category]
    
  @State private var label = ""
    
  var body: some View {
    Dialog(
      title: "new_category",
      description: "new_category_description",
      content: {
        GridRow {
          Text("category_label")
            .font(.caption)
            .gridColumnAlignment(.trailing)
          TextField("category_label", text: $label)
            .labelsHidden()
            .gridColumnAlignment(.leading)
            .onSubmit {
              addCategory()
            }
        }
      },
      actions: {
        DialogButton(
          title: "cancel",
          action: { dismiss() }
        )
        .keyboardShortcut(.cancelAction)
        DialogButton(
          title: "add",
          action: {
            addCategory()
            dismiss()
          }
        )
        .disabled(label.isEmpty)
        .keyboardShortcut(.defaultAction)
      }
    )
  }
    
  private func addCategory() {
    let newCategory = Category(id: UUID().uuidString, label: label, system: false, order: categories.count)
    modelContext.insert(newCategory)
  }
}

#Preview {
  AddCategoryView()
}
