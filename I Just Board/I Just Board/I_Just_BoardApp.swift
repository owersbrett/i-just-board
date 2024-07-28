//
//  I_Just_BoardApp.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//

import SwiftUI
import SwiftData

@main
struct I_Just_BoardApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Board.self,
            Card.self

        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView(boardListController: BoardListController.init(), currentViewController: CurrentViewController.init())
        }
        .modelContainer(sharedModelContainer)
    }
}
