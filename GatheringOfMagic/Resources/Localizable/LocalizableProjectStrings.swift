//
//  LocalizableProjectStrings.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 09/10/22.
//

import Foundation

enum FirstOpenTexts: String, Localizable {
    case firstOpen = "FirstOpenTexts_firstOpen"
    case notFirstOpen = "FirstOpenTexts_notFirstOpen"
}

enum TabBarTexts: String, Localizable {
    case cards = "TabBarTexts_cards"
    case favorites = "TabBarTexts_favorites"
    case decks = "TabBarTexts_decks"
}

enum CardDetailScreenTexts: String, Localizable {
    case favorite = "CardDetailScreenTexts_favorite"
    case unfavorite = "CardDetailScreenTexts_unfavorite"
    case newDeckCreated = "CardDetailScreenTexts_newDeckCreated"
}

enum FavoriteListScreenTexts: String, Localizable {
    case title = "FavoriteListScreenTexts_title"
}

enum DeckListScreenTexts: String, Localizable {
    case title = "DeckListScreenTexts_title"
}

enum DeckDetailScreenTexts: String, Localizable {
    case mana = "DeckDetailScreenTexts_mana"
    case averageCost = "DeckDetailScreenTexts_averageCost"
    case land = "DeckDetailScreenTexts_land"
    case instant = "DeckDetailScreenTexts_instant"
    case sorcery = "DeckDetailScreenTexts_sorcery"
    case artifact = "DeckDetailScreenTexts_artifact"
    case creature = "DeckDetailScreenTexts_creature"
    case enchantment = "DeckDetailScreenTexts_enchantment"
    case planeswalker = "DeckDetailScreenTexts_planeswalker"
}

enum AlertTexts: String, Localizable {
    case alert = "AlertTexts_alert"
    case ok = "AlertTexts_ok"
}

enum ErrorMessages: String,Localizable {
    case noWindow = "ErrorMessages_noWindow"
    case failureAPI = "ErrorMessages_failureAPI"
    case failureMock = "ErrorMessages_failureMock"
    case coreDataUnableFetch = "ErrorMessages_coreDataUnableFetch"
    case errorFetchingDecks = "ErrorMessages_errorFetchDecks"
    case errorFetchingCards = "ErrorMessages_errorFetchCards"
    case unresolvedError = "ErrorMessages_unresolvedError"
    
}
