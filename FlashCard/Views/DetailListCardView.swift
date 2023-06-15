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
    @State private var isRenaming = false
    @State private var name = ""
    @State private var isFullSize = false
    @State private var isStudying = false
    
    @ViewBuilder
    func studyView() -> some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    isStudying.toggle()
                } label: {
                    Image(systemName: "xmark")
                }
            }
            .padding()
            
            Spacer()
            
            TabView {
                ForEach(topic.cards) { card in
                    CardView(card: card)
                        .frame(height: 500)
                        .padding()
                }
            }
            
            Spacer()
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .background(Color(uiColor: .systemGray6))

    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(topic.cards) { card in
                    CardView(card: card)
                        .frame(height: isFullSize ? 500 : 250)
                }
            }
        }
        .background(Color(uiColor: .systemGray6))
        .contentMargins(20, for: .scrollContent)
        .navigationTitle(topic.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Button {
                        isStudying.toggle()
                    } label: {
                        Image(systemName: "play")
                    }
                    .disabled(topic.cards.isEmpty)
                    .fullScreenCover(isPresented: $isStudying) { studyView() }
                    
                    Button {
                        showAddingNewCard = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Menu {
                    Button {
                        name = topic.name
                        isRenaming = true
                    } label: {
                        Label("Rename Topic", systemImage: "pencil.line")
                    }
                    
                    Button {
                        isFullSize.toggle()
                    } label: {
                        if isFullSize {
                            Label("Compact size", systemImage: "rectangle.on.rectangle.angled")
                        } else {
                            Label("Full size", systemImage: "rectangle.portrait.on.rectangle.portrait.angled")
                        }
                    }
                    
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
                    
                    Button {
                        isFullSize = false
                        columns = [GridItem(.flexible())]
                    } label: {
                        Label("Reset", systemImage: "arrow.circlepath")
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
        .alert("Rename", isPresented: $isRenaming) {
            TextField("Name", text: $name)
            Button("Save", role: .destructive) {
                topic.name = name
            }
        }
    }
}
