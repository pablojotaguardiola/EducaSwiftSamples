//
//  ContentView.swift
//  SideMenuModifier
//
//  Created by Pablo Guardiola on 9/12/24.
//

import SwiftUI

struct ContentView: View {

    @State var showMenu: Bool = false

    var body: some View {
        VStack {
            Button {
                showMenu.toggle()
            } label: {
                Text("Toggle Menu")
                    .foregroundStyle(.white)
                    .font(.headline)
                    .padding()
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }

        }
        .padding()
        .sideMenu(showMenu: $showMenu) {
            MyMenu()
        }
    }
}

#Preview {
    ContentView()
}
