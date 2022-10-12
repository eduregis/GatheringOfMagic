//
//  DeckDetailScreenPresenter.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 08/10/22.
//

import UIKit
import CoreData

protocol DeckDetailScreenPresenterDelegate: BasePresenterDelegate {
}

class DeckDetailScreenPresenter {
    
    // MARK: - Variables
    weak var delegate: DeckDetailScreenPresenterDelegate?
    let router: DeckDetailScreenRouter
    var currentDeck: CD_Deck?
    var cards: [CD_CardDetail] = []
    var completionHandler: (() -> Void)?
    
    var sortedCards = [CardTypes: [CD_CardDetail]]()
    
    init(deck: CD_Deck, completion: (() -> Void)?, delegate: DeckDetailScreenPresenterDelegate, router: DeckDetailScreenRouter) {
        self.delegate = delegate
        self.router = router
        self.completionHandler = completion
        self.cards = DataManager.shared.getCards(deck: deck)
        currentDeck = deck
    }
    
    func didLoad() {
        sortingCards()
    }
    
    func willAppear() {
    }
    
    func didAppear() {
    }
    
    func reloadDeck() {
        guard let deck = currentDeck else { return }
        self.cards = DataManager.shared.getCards(deck: deck)
        self.sortingCards()
    }
    
    func sortingCards() {
        sortedCards[.land] = cards.filter({$0.type!.contains("Land")})
        sortedCards[.instant] = cards.filter({$0.type!.contains("Instant")})
        sortedCards[.sorcery] = cards.filter({$0.type!.contains("Sorcery")})
        sortedCards[.artifact] = cards.filter({$0.type!.contains("Artifact")})
        sortedCards[.creature] = cards.filter({$0.type!.contains("Creature")})
        sortedCards[.enchantment] = cards.filter({$0.type!.contains("Enchantment")})
        sortedCards[.planeswalker] = cards.filter({$0.type!.contains("Planeswalker")})
    }
    
    func titleForHeader(type: CardTypes) -> String {
        switch type {
        case .land:
            return DeckDetailScreenTexts.land.localized()
        case .instant:
            return DeckDetailScreenTexts.instant.localized()
        case .sorcery:
            return DeckDetailScreenTexts.sorcery.localized()
        case .artifact:
            return DeckDetailScreenTexts.artifact.localized()
        case .creature:
            return DeckDetailScreenTexts.creature.localized()
        case .enchantment:
            return DeckDetailScreenTexts.enchantment.localized()
        case .planeswalker:
            return DeckDetailScreenTexts.planeswalker.localized()
        case .total:
            return ""
        }
    }
    
    func totalCardsInDeck() -> Int {
        var totalCount = 0
        for card in cards {
            totalCount += Int(card.quantity)
        }
        return totalCount
    }
    
    func averageCostInDeck() -> CGFloat {
        var cardsWithCost = 0
        var totalCost = 0
        
        for card in cards {
            if (card.cmc > 0) {
                cardsWithCost += Int(card.quantity)
                totalCost += Int(card.quantity) * Int(card.cmc)
            }
        }
        return CGFloat(totalCost/cardsWithCost)
    }

    func navigateToEditDeck() {
        guard let deck = currentDeck else { return }
        router.navigateToEditDeck(deck: deck)
    }
    
}
