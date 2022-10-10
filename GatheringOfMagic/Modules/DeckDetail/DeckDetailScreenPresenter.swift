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

enum CardTypes: Int {
    case land = 0, instant, sorcery, artifact, creature, enchantment, planeswalker, total
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
    
    func backToList() {
        router.backToList()
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
    
    func loadCard(completion: @escaping () -> Void) {
        
    }
    
    func addToDeck(deck: CD_Deck) {
        
    }
    
    func createDeck() {
        
    }
}
