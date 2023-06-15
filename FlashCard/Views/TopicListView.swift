//
//  ListCardsView.swift
//  FlashCard
//
//  Created by Huy Ong on 6/11/23.
//

import SwiftUI
import SwiftData

struct TopicListView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \.createdDate, order: .reverse, animation: .default)
    private var topics: [Topic]
    
    @State private var searchText = ""
    
    var filteredTopics: [Topic] {
        return topics.filter { topic in
            searchText.isEmpty || topic.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    var searchView: some View {
        ForEach(filteredTopics) { topic in
            NavigationLink(topic.name, value: topic)
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        modelContext.delete(object: topic)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(topics) { topic in
                    NavigationLink(topic.name, value: topic)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                modelContext.delete(object: topic)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
                .onDelete(perform: deleteTopics(at:))
            }
            .searchable(text: $searchText, prompt: "Search") {
                searchView
            }
            .navigationTitle("Topics")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                        .disabled(topics.isEmpty)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        let topic = Topic(name: "New Topic")
                        modelContext.insert(topic)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationDestination(for: Topic.self) { topic in
                DetailListCardView(topic: topic)
            }
        }
    }
    
    private func deleteTopics(at offsets: IndexSet) {
        withAnimation {
            offsets.map { topics[$0] }.forEach(deleteTopic)
        }
    }
    
    private func deleteTopic(_ topic: Topic) {
        modelContext.delete(topic)
    }
}
