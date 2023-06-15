//
//  FlashCardApp.swift
//  FlashCard
//
//  Created by Huy Ong on 6/9/23.
//

import SwiftUI

@main
struct FlashCardApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Topic.self, Card.self])
    }
}
        
