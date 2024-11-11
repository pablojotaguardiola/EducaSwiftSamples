//
//  ContentView.swift
//  EducaSwiftMacros
//
//  Created by Pablo Guardiola on 11/11/24.
//

import SwiftUI
import EducaSwiftHexMacroPackage

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(#hexColor("FFFF00FF"))
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
