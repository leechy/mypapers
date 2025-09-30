//
//  AddStackView.swift
//  mypapers
//
//  Created by Andrey Lechev on 29/09/2025.
//

import SwiftUI
import SwiftData

struct AddStackView: View {
  @Environment(\.modelContext) private var modelContext
  @Environment(\.dismiss) private var dismiss
  @Query(sort: \Stack.order) private var stacks: [Stack]

  @State private var name = ""
  @State private var selectedType: StackType = .folder
    
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
                Text("new_stack")
                  .font(.headline)
                Text("new_stack_description")
                  .font(.subheadline)
                  .multilineTextAlignment(.leading)
              }
            }
            .padding(.bottom, 12)

            GridRow {
              Text("stack_type_label")
                .font(.caption)
                .gridColumnAlignment(.trailing)
              Picker("stack_type_label", selection: $selectedType) {
                ForEach([StackType.folder, .project, .collection, .trip], id: \.self) { type in
                  Label(type.displayName, systemImage: type.iconName).tag(type)
                }
              }
              .labelsHidden()
              .gridColumnAlignment(.leading)
            }
            
            GridRow {
              Text("stack_name_label")
                .font(.caption)
                .gridColumnAlignment(.trailing)
              TextField("stack_name_label", text: $name)
                .labelsHidden()
                .gridColumnAlignment(.leading)
                .onSubmit {
                  addStack()
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
              addStack()
            } label: {
              Text("add")
                .padding(.horizontal, 8)
                .padding(.vertical, 2)
                .frame(minWidth: 62)
            }
            .disabled(name.isEmpty)
          }
          .padding(4)
        }
      }
      .padding()
      
    }
    .frame(maxWidth: 400)
  }
    
  private func addStack() {
    if !name.isEmpty {
      let newStack = Stack(id: UUID().uuidString, name: name, type: selectedType, order: stacks.count)
      modelContext.insert(newStack)
      dismiss()
    }
  }
}

#Preview {
  AddStackView()
}
