//
//  ListCardsView.swift
//  FlashCard
//
//  Created by Huy Ong on 6/11/23.
//

import SwiftUI
import SwiftData

actor PreviewSampleData {
    @MainActor
    static var container: ModelContainer = {
        let schema = Schema([Topic.self])
        let configuration = ModelConfiguration(inMemory: true)
        let container = try! ModelContainer(for: schema, configurations: [configuration])
        let sampleData: [any PersistentModel] = [
            Topic.preview
        ]
        sampleData.forEach {
            container.mainContext.insert($0)
        }
        return container
    }()
}

struct TopicListView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \.createdDate, order: .reverse, animation: .default)
    private var topics: [Topic]
    
    
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
            .navigationTitle("Topics")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
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
