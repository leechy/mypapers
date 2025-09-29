//
//  AddCategoryView.swift
//  mypapers
//
//  Created by Andrey Lechev on 29/09/2025.
//

import SwiftUI
import SwiftData

struct AddCategoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query(sort: \Category.order) private var categories: [Category]
    
    @State private var label = ""
    
    var body: some View {
        NavigationStack {
          VStack {
            Form {
              TextField("category_label", text: $label)
            }
            HStack {
              Spacer()
              Button {
                dismiss()
              } label: {
                Text("cancel")
                  .padding(.horizontal, 8)
                  .padding(.vertical, 2)
                  .frame(minWidth: 62)
              }
              Button {
                addCategory()
              } label: {
                Text("add")
                  .padding(.horizontal, 8)
                  .padding(.vertical, 2)
                  .frame(minWidth: 62)
              }
              .disabled(label.isEmpty)
            }
          }
          .navigationTitle("add_category")
          .padding()
        }
        .frame(maxWidth: 400)
        .toolbarTitleDisplayMode(.inline)
    }
    
    private func addCategory() {
        let newCategory = Category(id: UUID().uuidString, label: label, system: false, order: categories.count)
        modelContext.insert(newCategory)
        dismiss()
    }
}

#Preview {
  AddCategoryView()
}
