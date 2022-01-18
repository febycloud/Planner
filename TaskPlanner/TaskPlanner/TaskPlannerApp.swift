//
//  TaskPlannerApp.swift
//  TaskPlanner
//
//  Created by Fei Yun on 2022-01-17.
//

import SwiftUI

@main
struct TaskPlannerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
