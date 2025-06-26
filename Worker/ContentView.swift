//
//  ContentView.swift
//  Worker
//
//  Created by John Siracusa on 6/26/25.
//

import SwiftUI

struct ContentView: View {
    let appState : AppState

    @State private var generateDisabled = false
    @State private var processDisabled = true
    @State private var processing = false
    @State private var processed = 0

    var body: some View {
        VStack(spacing: 16) {
            Button(generateDisabled ? "Generating…" : "Generate Products") {
                Task {
                    generateDisabled = true
                    await appState.generateProducts()
                    generateDisabled = false
                    processDisabled = false
                }
            }
            .disabled(generateDisabled)

            Text("Products generated: \(appState.numProducts)")

            Button(processing ? "Processing…" : "Process Products") {
                Task {
                    processing = true
                    processDisabled = true
                    processed = await appState.processProducts()
                    processDisabled = false
                    processing = false
                }
            }
            .disabled(processDisabled)

            Text("Products processed: \(processed)")
        }
        .padding()
    }
}

#Preview {
    let appState = AppState()
    ContentView(appState: appState)
}
