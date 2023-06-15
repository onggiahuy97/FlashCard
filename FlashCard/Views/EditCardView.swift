//
//  EditCardView.swift
//  FlashCard
//
//  Created by Huy Ong on 6/13/23.
//

import SwiftUI

struct EditCardView: View {
    var card: Card
    
    @State private var fontContent: String
    @State private var backContent: String
    
    init(card: Card) {
        self.card = card
        _fontContent = State(initialValue: card.fontContent)
        _backContent = State(initialValue: card.backContent)
    }
    
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
                    HStack {
                        Button("Cancel", role: .destructive, action: dismiss.callAsFunction)
                        Button("Delete") {
                            if let topic = card.topic,
                               let index = topic.cards.firstIndex(where: { $0.objectID == card.objectID }) {
                                topic.cards.remove(at: index)
                            }
                            dismiss()
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        card.fontContent = fontContent
                        card.backContent = backContent
                        dismiss()
                    }
                }
            }
        }
    }
}
