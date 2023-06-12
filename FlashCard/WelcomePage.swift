//
//  WelcomePage.swift
//  FlashCard
//
//  Created by Huy Ong on 6/12/23.
//

import SwiftUI

struct WelcomePage: View {
    @State private var flag = true
    
    var body: some View {
        ZStack {
            ForEach(0..<10, id: \.self) { item in
                Image(systemName: "trash")
                    .offset(flag ? .zero : randoomSize())
                    .animation(.bouncy(duration: 0.75), value: flag)
                    .symbolEffect(.bounce, value: flag)
            }
            RoundedRectangle(cornerRadius: 25.0)
                .frame(width: 100, height: 100)
                .foregroundStyle(.blue)
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                flag.toggle()
            }
        }
    }
    
    private func randoomSize() -> CGSize {
        let circleRadius: CGFloat = 45
        let centerX = circleRadius
        let centerY = circleRadius
        
        var generatedPoint: CGPoint
        var distanceFromCenter: CGFloat
        
        repeat {
            let randomX = CGFloat.random(in: 0...(circleRadius * 2))
            let randomY = CGFloat.random(in: 0...(circleRadius * 2))
            generatedPoint = CGPoint(x: randomX, y: randomY)
            distanceFromCenter = sqrt(pow(generatedPoint.x - centerX, 2) + pow(generatedPoint.y - centerY, 2))
        } while distanceFromCenter > circleRadius
        
        let randomSize = CGSize(width: generatedPoint.x, height: generatedPoint.y)
        return randomSize
    }
}

#Preview {
    WelcomePage()
}
