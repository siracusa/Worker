//
//  WorkerApp.swift
//  Worker
//
//  Created by John Siracusa on 6/26/25.
//

import SwiftUI

@main
struct WorkerApp : App {
    let appState = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView(appState: appState)
        }
    }
}
