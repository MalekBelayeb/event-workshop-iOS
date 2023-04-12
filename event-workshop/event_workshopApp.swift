//
//  event_workshopApp.swift
//  event-workshop
//
//  Created by ODC on 12/4/2023.
//

import SwiftUI

@main
struct event_workshopApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
