//
//  Card.swift
//  FlashCard
//
//  Created by Huy Ong on 6/9/23.
//

import Foundation
import SwiftUI
import SwiftData

@Model class Card {
    var fontContent: String
    var backContent: String
    var createdDate: Date
    var topic: Topic?
    
    init(fontContent: String = "", backContent: String = "") {
        self.fontContent = fontContent
        self.backContent = backContent
        createdDate = Date()
    }
}

extension Card {
    @Transient
    var color: Color {
        let combinedString = fontContent + backContent
        let seed = combinedString.hashValue
        var generator: RandomNumberGenerator = SeededRandomGenerator(seed: seed)
        return .random(using: &generator)
    }
    
    static var preview: Card {
        Card(fontContent: "Testing Font", backContent: "Testing Back")
    }
}

private struct SeededRandomGenerator: RandomNumberGenerator {
    init(seed: Int) {
        srand48(seed)
    }
    
    func next() -> UInt64 {
        UInt64(drand48() * Double(UInt64.max))
    }
}

private extension Color {
    static var random: Color {
        var generator: RandomNumberGenerator = SystemRandomNumberGenerator()
        return random(using: &generator)
    }
    
    static func random(using generator: inout RandomNumberGenerator) -> Color {
        let red = Double.random(in: 0..<1, using: &generator)
        let green = Double.random(in: 0..<1, using: &generator)
        let blue = Double.random(in: 0..<1, using: &generator)
        return Color(red: red, green: green, blue: blue)
    }
}
