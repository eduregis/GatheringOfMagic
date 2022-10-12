//
//  Enums.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 10/10/22.
//

import Foundation

enum CardTypes: Int {
    case land = 0, instant, sorcery, artifact, creature, enchantment, planeswalker, total
}

enum DeckFormats: Int, CaseIterable {
    case standard = 0, commander, vintage
    
    static let allValues = [standard, commander, vintage]
}
