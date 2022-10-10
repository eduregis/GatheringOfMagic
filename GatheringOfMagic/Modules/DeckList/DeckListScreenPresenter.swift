//
//  DeckListScreenPresenter.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 08/10/22.
//

import Foundation

protocol DeckListScreenPresenterDelegate: BasePresenterDelegate {
}

class DeckListScreenPresenter {
    
    weak var delegate: DeckListScreenPresenterDelegate?
    let router: DeckListScreenRouter
    
    var decks: [CD_Deck]?
    
    init(delegate: DeckListScreenPresenterDelegate, router: DeckListScreenRouter) {
        self.delegate = delegate
        self.router = router
    }
    
    func didLoad() {
    }
    
    func willAppear() {
    }
    
    func didAppear() {
    }
    
    func updateDecks() {
        self.decks = DataManager.shared.getDecks()
    }
    
    func loadDecks(completion: @escaping () -> Void) {
        
        delegate?.showLoader()
        
        DispatchQueue.main.async {
            self.updateDecks()
            self.delegate?.hideLoader()
            completion()
        }
    }
    
    func navigateToCardList() {
    }
}
