//
//  CovidCTApp.swift
//  CovidCT
//
//  Created by Matt Keyzer on 2/9/24.
//

import SwiftUI

@main
struct CovidCTApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
