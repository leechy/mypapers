//
//  PapersScreen.swift
//  mypapers
//
//  Created by Andrey Lechev on 30/09/2025.
//

import SwiftUI

struct PapersScreen: View {
  let stack: String?
  let category: String?
  
    var body: some View {
      Text("Hello, This is the Papers screen!")
      Text("Category: \(category ?? "none")")
      Text("Stack: \(stack ?? "none")")
    }
}

#Preview {
  PapersScreen(stack: "Selected Stack", category: "Custom Category")
}
