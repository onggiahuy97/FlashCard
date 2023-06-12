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
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .overlay(alignment: .center) {
                    if isFont {
                        Text(card.fontContent)
                            .foregroundStyle(.white)
                    } else {
                        Text(card.backContent)
                            .foregroundStyle(.white)
                            .rotation3DEffect(
                                .degrees(180),
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                    }
                }
                .bold()
                .foregroundStyle(isFont ? card.color.gradient : Color.secondary.opacity(0.65).gradient)
        }
        .frame(height: 250)
        .rotation3DEffect(
            .degrees(rotation),
            axis: (x: 0.0, y: -1.0, z: 0.0),
            anchor: .center,
            anchorZ: 0,
            perspective: 0.3
        )
        .rotation3DEffect(
            .degrees(isFont ? .zero : 7.5),
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )
        .onTapGesture {
            withAnimation(.bouncy(duration: 0.5)) {
                isFont.toggle()
                rotation += 180
            }
        }
    }
}
