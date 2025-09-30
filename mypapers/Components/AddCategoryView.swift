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
      Form {
        VStack(alignment: .leading) {
          Grid {
            GridRow {
              Image("MyPapers Icon")
                .resizable()
                .scaledToFit()
                .frame(width: 64, height: 64)
                .gridColumnAlignment(.trailing)
              
              VStack(alignment: .leading, spacing: 8) {
                Text("new_category")
                  .font(.headline)
                Text("new_category_description")
                  .font(.subheadline)
                  .multilineTextAlignment(.leading)
              }
            }
            .padding(.bottom, 12)
            
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
          }
          .padding(.trailing, 4)
          .padding(.bottom, 4)
          
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
          .padding(4)
        }
      }
      .padding()
      
    }
    .frame(maxWidth: 400)
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
