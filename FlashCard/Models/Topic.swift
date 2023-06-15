//
//  Topic.swift
//  FlashCard
//
//  Created by Huy Ong on 6/14/23.
//

import Foundation
import SwiftUI
import SwiftData

@Model class Topic {
    var name: String
    var cards: [Card] = []
    var createdDate: Date
    
    init(name: String = "") {
        self.name = name
        createdDate = Date()
    }
}

extension Topic {
    static var preview: Topic {
        Topic(name: "Sample Data for Preview")
    }
}
