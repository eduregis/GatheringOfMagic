//
//  FavoriteListScreenPresenter.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 08/10/22.
//

import Foundation

protocol FavoriteListScreenPresenterDelegate: BasePresenterDelegate {
}

class FavoriteListScreenPresenter {
    
    weak var delegate: FavoriteListScreenPresenterDelegate?
    let router: FavoriteListScreenRouter
    
    var favoriteCards: [CD_CardDetail]?
    
    init(delegate: FavoriteListScreenPresenterDelegate, router: FavoriteListScreenRouter) {
        
        self.delegate = delegate
        self.router = router
    }
    func didLoad() {
    }
    
    func willAppear() {
    }
    
    func didAppear() {
    }
    
    func updateFavorites() {
        if let favorites = DataManager.shared.getDeckByName(name: "Favorites") {
            self.favoriteCards = DataManager.shared.getCards(deck: favorites)
        }
    }
    
    func loadFavoriteCards(completion: @escaping () -> Void) {
        
        delegate?.showLoader()
        
        DispatchQueue.main.async {
            self.updateFavorites()
            self.delegate?.hideLoader()
            completion()
        }
    }
    
    func navigateToCardList() {
    }
}
