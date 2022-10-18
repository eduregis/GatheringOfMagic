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
    var pagination: Int = 0
    
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
    }
    
    func navigateToCardDetail(cardId: String, isFavorited: Bool) {
        self.router.navigateToCardDetail(cardId: cardId, isFavorited: isFavorited)
    }
    
    func updateFavorites() {
        if let favorites = DataManager.shared.getDeckByName(name: "Favorites") {
            favoriteCards = DataManager.shared.getCards(deck: favorites)
        }
    }
    
    func loadCards(name: String, completion: @escaping () -> Void) {
        
        delegate?.showLoader()
        pagination = 0
        
        VehicleDAO.getCards(
            page: 0,
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
            
            SnackBarHelper.shared.showErrorMessage(message: error.error ?? "")
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func loadMoreCards(name: String, completion: @escaping () -> Void) {
        pagination += 1
        
        VehicleDAO.getCards(
            page: pagination,
            name: name,
            success: { gathering in
                DispatchQueue.main.async {
                    guard let cards = gathering.cards else { return }
                    self.currentCards?.append(contentsOf: cards)
                    completion()
                }
        }) { error in
            SnackBarHelper.shared.showErrorMessage(message: error.error ?? "")
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
