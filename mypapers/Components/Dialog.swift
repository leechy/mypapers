//
//  Dialog.swift
//  mypapers
//
//  Created by Andrey Lechev on 30/09/2025.
//

import SwiftUI

struct Dialog<Content: View>: View {
    @Environment(\.dismiss) private var dismiss
    
    let title: LocalizedStringKey
    let description: LocalizedStringKey
    @ViewBuilder let content: () -> Content
    let actionText: LocalizedStringKey
    let actionDisabled: Bool
    let onAction: () -> Void
    
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
                                Text(title)
                                    .font(.headline)
                                Text(description)
                                    .font(.subheadline)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                        .padding(.bottom, 12)
                        
                        content()
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
                            onAction()
                            dismiss()
                        } label: {
                            Text(actionText)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 2)
                                .frame(minWidth: 62)
                        }
                        .disabled(actionDisabled)
                    }
                    .padding(4)
                }
            }
            .padding()
        }
        .frame(maxWidth: 400)
    }
}

#Preview {
    Dialog(
        title: "new_stack",
        description: "new_stack_description",
        content: {
            GridRow {
                Text("stack_name_label")
                    .font(.caption)
                    .gridColumnAlignment(.trailing)
                TextField("stack_name_label", text: .constant(""))
                    .labelsHidden()
                    .gridColumnAlignment(.leading)
            }
        },
        actionText: "add",
        actionDisabled: false,
        onAction: {}
    )
}