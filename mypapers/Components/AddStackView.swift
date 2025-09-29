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
              Text("stack_type")
                .gridColumnAlignment(.trailing)
              Picker("stack_type", selection: $selectedType) {
                ForEach([StackType.folder, .project, .collection, .trip], id: \.self) { type in
                  Label(type.displayName, systemImage: type.iconName).tag(type)
                }
              }
              .labelsHidden()
              .gridColumnAlignment(.leading)
            }
            
            GridRow {
              Text("stack_name")
                .gridColumnAlignment(.trailing)
              TextField("stack_name", text: $name)
                .labelsHidden()
                .gridColumnAlignment(.leading)
                .onSubmit {
                  addStack()
                }
            }
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
              addStack()
            } label: {
              Text("add")
                .padding(.horizontal, 8)
                .padding(.vertical, 2)
                .frame(minWidth: 62)
            }
            .disabled(name.isEmpty)
          }
        }
      }
      .navigationTitle("add_stack")
      .padding()
    }
    .frame(maxWidth: 400)
    .toolbarTitleDisplayMode(.inline)
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
