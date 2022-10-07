//
//  Cards.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 05/10/22.
//

import Foundation

class Cards: Codable {
    var cards: [Card]?
}

class Card: Codable {
    var name: String?
    var cmc: Int?
    var colors: [String]?
    var type: String?
    var rarity: String?
    var imageUrl: String?
    var id: String?
    
    
    enum CodingKeys: String, CodingKey {
        case name, cmc, colors, type, rarity, imageUrl, id
    }
}

class CardResponse: Codable {
    var card: CardDetail?
}

class CardDetail: Codable {
    var name: String?
    var cmc: Int?
    var colors: [String]?
    var type: String?
    var rarity: String?
    var artist: String?
    var power: String?
    var toughness: String?
    var imageUrl: String?
    var id: String?
    
    
    enum CodingKeys: String, CodingKey {
        case name, cmc, colors, type, rarity, artist, power, toughness, imageUrl, id
    }
}
