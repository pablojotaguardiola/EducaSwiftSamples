//
//  TCATreeBasedNavigationApp.swift
//  TCATreeBasedNavigation
//
//  Created by Pablo Guardiola on 26/12/24.
//

import ComposableArchitecture
import SwiftUI

@main
struct TCATreeBasedNavigationApp: App {

    @State var mainMenuStore = Store(initialState: MainMenu.State()) {
        MainMenu()
    }

    var body: some Scene {
        WindowGroup {
            MainMenuView(store: $mainMenuStore)
        }
    }
}
