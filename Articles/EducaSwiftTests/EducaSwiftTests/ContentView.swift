//
//  ContentView.swift
//  EducaSwiftTests
//
//  Created by Pablo Guardiola on 12/10/24.
//

import SwiftUI

struct ContentView: View {

    @State var viewModel: MyViewModel = MyViewModel()

    var body: some View {
        Text("\(viewModel.getSquare(number: 2))")
    }
}

#Preview {
    ContentView()
}
