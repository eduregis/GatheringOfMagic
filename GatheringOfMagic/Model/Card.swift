//
//  Card.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 11/08/20.
//  Copyright © 2020 Eduardo Oliveira. All rights reserved.
//

import Foundation

struct Deck: Codable, Equatable {
    var name: String?
    var main: DeckComponent
    var sideboard: DeckComponent?
    
    init () {
        name = "New deck"
        main = DeckComponent()
        sideboard = DeckComponent()
    }
}

struct DeckComponent: Codable, Equatable {
    var deckCards: [DeckCard]
    
    init () {
        deckCards = []
    }
}

struct DeckCard: Codable, Equatable {
    var card: Card
    var quantity: Int
    
    init(card: Card, quantity: Int) {
        self.card = card
        self.quantity = quantity
    }
}

struct Cards: Codable, Equatable {
    var cards: [Card]
}

struct Card: Codable, Equatable {
    var name: String
    var manaCost: String?
    var type: String
    var rarity: String
    var power: String?
    var toughness: String?
    var set: String
    var artist: String
    var imageUrl: String?
    var text: String?
    var flavor: String?
    var loyalty: String?
    var id: String
    var colors: [String]
    
    init () {
        name = ""
        type = ""
        rarity = ""
        set = ""
        artist = ""
        id = ""
        colors = []
    }
}
