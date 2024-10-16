//
//  EducaSwiftCoreDataApp.swift
//  EducaSwiftCoreData
//
//  Created by Pablo Guardiola on 16/10/24.
//

import SwiftUI

@main
struct EducaSwiftCoreDataApp: App {

    @State private var coreData = CoreData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreData.container.viewContext)
        }
    }
}
