//
//  Card.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 11/08/20.
//  Copyright © 2020 Eduardo Oliveira. All rights reserved.
//

import Foundation

struct Cards: Codable, Equatable  {
    var cards: [Card]
}

struct Card: Codable, Equatable  {
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
}
