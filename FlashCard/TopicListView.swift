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
    
    @Query private var topics: [Topic]
    
    var body: some View {
        NavigationStack {
            List(topics) { topic in
                NavigationLink(topic.name, value: topic)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            modelContext.delete(object: topic)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
            }
            .navigationTitle("Topics")
            .toolbar {
                Button("Add Sample") {
                    let topic = Topic(name: "From Swiftui With Lovess")
                    modelContext.insert(topic)
                }
            }
            .navigationDestination(for: Topic.self) { topic in
                DetailListCardView(topic: topic)
            }
        }
    }
}
