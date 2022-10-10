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

enum DeckFormats: String {
    case standard = "Standard"
    case commander = "Commander"
    case vintage = "Vintage"
}
