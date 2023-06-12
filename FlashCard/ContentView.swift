//
//  ContentView.swift
//  FlashCard
//
//  Created by Huy Ong on 6/9/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TopicListView()
                .tabItem {
                    Label("Home", systemImage: "list.bullet.rectangle.portrait")
                }
        }
    }
}

#Preview {
    ContentView()
}
