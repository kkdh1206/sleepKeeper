//
//  Sleep_Keeper_SwiftDataApp.swift
//  Sleep_Keeper_SwiftData
//
//  Created by user on 7/4/24.
//

import SwiftUI
import SwiftData

@main
struct Sleep_Keeper_SwiftDataApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            SleepStartTime.self,
            WakeUpTime.self,
            RemainTime.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
            print("where?")
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
        
    }
}
