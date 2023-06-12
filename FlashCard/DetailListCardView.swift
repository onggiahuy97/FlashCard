//
//  HomeView.swift
//  FlashCard
//
//  Created by Huy Ong on 6/9/23.
//

import SwiftUI
import SwiftData

struct DetailListCardView: View {
    
    var topic: Topic
    
    @State private var showAddingNewCard = false
    @State private var columns: [GridItem] = [GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(topic.cards) { card in
                    CardView(card: card)
                }
            }
        }
        .contentMargins(20, for: .scrollContent)
        .navigationTitle(topic.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showAddingNewCard = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Menu {
                    Button {
                        columns = [GridItem(.flexible())]
                    } label: {
                        Label("Default", systemImage: "rectangle.grid.1x2")
                    }
                    Button {
                        columns = [GridItem(.flexible()), GridItem(.flexible())]
                    } label: {
                        Label("Compact", systemImage: "square.grid.2x2")
                    }
                } label: {
                    Image(systemName: "gear")
                }
            }
        }
        .sheet(isPresented: $showAddingNewCard) {
            AddNewCardView(topic: topic)
                .presentationDetents([.medium, .large])
        }
    }
}