//
//  CardListScreenPresenter.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 05/10/22.
//

import UIKit
import CoreData

protocol CardListScreenPresenterDelegate: BasePresenterDelegate {
}

class CardListScreenPresenter {
    
    weak var delegate: CardListScreenPresenterDelegate?
    let router: CardListScreenRouter
    
    var currentCards: [Card]?
    var favoriteCards: [CD_CardDetail]?
    
    init(delegate: CardListScreenPresenterDelegate, router: CardListScreenRouter) {
        self.delegate = delegate
        self.router = router
    }
    
    func didLoad() {
    }
    
    func willAppear() {
        updateFavorites()
    }
    
    func didAppear() {
        let decks = DataManager.shared.getDecks()
        for deck in decks {
            let cards = DataManager.shared.getCards(deck: deck)
            for card in cards {
                print(deck.name ?? "", ": ", card.name ?? "")
            }
        }
        
    }
    
    func navigateToCardDetail(cardId: String, isFavorited: Bool) {
        router.navigateToCardDetail(cardId: cardId, isFavorited: isFavorited)
    }
    
    func updateFavorites() {
        if let favorites = DataManager.shared.getDeckByName(name: "Favorites") {
            favoriteCards = DataManager.shared.getCards(deck: favorites)
        }
    }
    
    func loadCards(name: String, completion: @escaping () -> Void) {
        
        delegate?.showLoader()
        
        VehicleDAO.getCards(
            name: name,
            success: { gathering in
                DispatchQueue.main.async {
                    guard let cards = gathering.cards else { return }
                    
                    self.currentCards = cards
                    
                    self.delegate?.hideLoader()
                    completion()
                }
            }) { error in
                self.delegate?.hideLoader()
                self.delegate?.showMessage("erro, localized")
                DispatchQueue.main.async {
                    completion()
                }
            }
    }
    
    func isFavorited(card: Card?) -> Bool {
        guard let card = card else { return false }
        guard let favoriteCards = favoriteCards else { return false }
        
        for favoriteCard in favoriteCards {
            if (card.id == favoriteCard.id) { return true }
        }
        return false
    }
}
