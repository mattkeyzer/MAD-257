//
//  CovidContactTraceApp.swift
//  CovidContactTrace
//
//  Created by Matt Keyzer on 2/9/24.
//

import SwiftUI

@main
struct CovidContactTraceApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
