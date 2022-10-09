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
    
    init(deck: CD_Deck, completion: (() -> Void)?, delegate: DeckDetailScreenPresenterDelegate, router: DeckDetailScreenRouter) {
        self.delegate = delegate
        self.router = router
        self.completionHandler = completion
        self.cards = DataManager.shared.getCards(deck: deck)
        currentDeck = deck
    }
    
    func didLoad() {
    }
    
    func willAppear() {
    }
    
    func didAppear() {
    }
    
    func backToList() {
        router.backToList()
    }
    
    func loadCard(completion: @escaping () -> Void) {
        
    }
    
    func addToDeck(deck: CD_Deck) {
        
    }
    
    func createDeck() {
        
    }
}
