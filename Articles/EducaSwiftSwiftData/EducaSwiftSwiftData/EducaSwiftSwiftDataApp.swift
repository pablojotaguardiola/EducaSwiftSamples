//
//  EducaSwiftSwiftDataApp.swift
//  EducaSwiftSwiftData
//
//  Created by Pablo Guardiola on 14/10/24.
//

import SwiftUI

@main
struct EducaSwiftSwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: TodoTask.self)
        }
    }
}
