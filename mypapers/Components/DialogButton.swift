//
//  DialogButton.swift
//  mypapers
//
//  Created by Andrey Lechev on 01/10/2025.
//

import SwiftUI

struct DialogButton: View {
  let title: LocalizedStringKey
  let action: () -> Void
  
  var body: some View {
    Button {
      action()
    } label: {
      Text(title)
        .padding(.horizontal, 8)
        .padding(.vertical, 2)
        .frame(minWidth: 62)
    }
  }
}

#Preview {
  DialogButton(
    title: "I'm a Button",
    action: { print("Button action!") }
  )
}
