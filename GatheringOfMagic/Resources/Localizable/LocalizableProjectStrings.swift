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

enum CardListScreenTexts: String, Localizable {
    case loadingMoreCards = "CardListScreenTexts_loadingMoreCards"
}

enum CardDetailScreenTexts: String, Localizable {
    case favorite = "CardDetailScreenTexts_favorite"
    case unfavorite = "CardDetailScreenTexts_unfavorite"
    case createNewDeck = "CardDetailScreenTexts_createNewDeck"
    case addToDeck = "CardDetailScreenTexts_addToDeck"
    case newDeckCreated = "CardDetailScreenTexts_newDeckCreated"
}

enum FavoriteListScreenTexts: String, Localizable {
    case title = "FavoriteListScreenTexts_title"
    case emptyListMessage = "FavoriteListScreenTexts_emptyListMessage"
}

enum DeckListScreenTexts: String, Localizable {
    case title = "DeckListScreenTexts_title"
    case wantToDeleteDeck = "DeckListScreenTexts_wantToDeleteDeck"
    case emptyListMessage = "DeckListScreenTexts_emptyListMessage"
}

enum AddToDeckScreenTexts: String, Localizable {
    case title = "AddToDeckScreenTexts_title"
    case maxNumberOfCopies = "AddToDeckScreenTexts_maxNumberOfCopies"
    case cardAddedSuccess = "AddToDeckScreenTexts_cardAddedSuccess"
    case nilCard = "AddToDeckScreenTexts_nilCard"
}

enum DeckDetailScreenTexts: String, Localizable {
    case edit = "DeckDetailScreenTexts_edit"
    case mana = "DeckDetailScreenTexts_mana"
    case averageCost = "DeckDetailScreenTexts_averageCost"
    case curve = "DeckDetailScreenTexts_curve"
    case land = "DeckDetailScreenTexts_land"
    case instant = "DeckDetailScreenTexts_instant"
    case sorcery = "DeckDetailScreenTexts_sorcery"
    case artifact = "DeckDetailScreenTexts_artifact"
    case creature = "DeckDetailScreenTexts_creature"
    case enchantment = "DeckDetailScreenTexts_enchantment"
    case planeswalker = "DeckDetailScreenTexts_planeswalker"
}

enum EditDeckScreenTexts: String, Localizable {
    case deckName = "EditDeckScreenTexts_deckName"
    case deckFormat = "EditDeckScreenTexts_deckFormat"
}

enum EditCardQuantityAlertTexts: String, Localizable {
    case confirm = "EditCardQuantityAlertTexts_confirm"
    case cancel = "EditCardQuantityAlertTexts_cancel"
}

enum AlertTexts: String, Localizable {
    case alert = "AlertTexts_alert"
    case ok = "AlertTexts_ok"
    case cancel = "AlertTexts_cancel"
}

enum ErrorMessages: String, Localizable {
    case noWindow = "ErrorMessages_noWindow"
    case failureAPI = "ErrorMessages_failureAPI"
    case failureMock = "ErrorMessages_failureMock"
    case coreDataUnableFetch = "ErrorMessages_coreDataUnableFetch"
    case errorFetchingDecks = "ErrorMessages_errorFetchDecks"
    case errorFetchingCards = "ErrorMessages_errorFetchCards"
    case unresolvedError = "ErrorMessages_unresolvedError"
}

enum SnackBarTitleMessages: String, Localizable {
    case success = "SnackBarTitleMessages_success"
    case failure = "SnackBarTitleMessages_failure"
}
