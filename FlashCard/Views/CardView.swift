//
//  CardView.swift
//  FlashCard
//
//  Created by Huy Ong on 6/9/23.
//

import SwiftUI

struct CardView: View {
    var card: Card
    
    @State private var isFont = true
    @State private var rotation: Double = 0
    @State private var isEditing = false
    
    var body: some View {
        ZStack {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 25)
                    .overlay(alignment: .center) {
                        ZStack {
                            if isFont {
                                Text(card.fontContent)
                                    .foregroundStyle(.black)
                            } else {
                                Text(card.backContent)
                                    .foregroundStyle(.black)
                                    .rotation3DEffect(
                                        .degrees(180),
                                        axis: (x: 0.0, y: 1.0, z: 0.0)
                                    )
                            }
                        }
                        .padding()
                    }
                    .bold()
                    .foregroundStyle(.white)
                
            }
            .rotation3DEffect(
                .degrees(rotation),
                axis: (x: 0.0, y: -1.0, z: 0.0),
                anchor: .center,
                anchorZ: 0,
                perspective: 0.3
            )
            
            VStack {
                Spacer()
                HStack(alignment: .bottom, spacing: 12) {
                    Spacer()
                    Button {
                        isEditing = true
                    } label: {
                        Image(systemName: "text.magnifyingglass")
                    }
                    .sheet(isPresented: $isEditing) {
                        EditCardView(card: card)
                    }
                    .padding(8)
                    .background(.white)
                    .clipShape(Circle())
                    .offset(x: 8, y: 8)
                    .shadow(radius: 0.75)
                    
                }
            }
        }
        .onTapGesture {
            withAnimation(.bouncy(duration: 0.5)) {
                isFont.toggle()
                rotation += 180
            }
        }
    }
}
