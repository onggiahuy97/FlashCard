//
//  AddNewCardView.swift
//  FlashCard
//
//  Created by Huy Ong on 6/9/23.
//

import SwiftUI
import SwiftData

struct AddNewCardView: View {
    var topic: Topic
    
    @State private var fontContent: String = ""
    @State private var backContent: String = ""
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Font Card") {
                    TextField("Text", text: $fontContent, axis: .vertical)
                }
                
                Section("Back Card") {
                    TextField("Text", text: $backContent, axis: .vertical)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel", role: .destructive, action: dismiss.callAsFunction)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let card = Card(fontContent: fontContent, backContent: backContent)
                        card.topic = topic
                        modelContext.insert(card)
                        topic.cards.append(card)
                        dismiss()
                    }
                }
            }
        }
    }
}
