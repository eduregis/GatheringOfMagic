//
//  CardListScreenPresenter.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 05/10/22.
//

import Foundation

protocol CardListScreenPresenterDelegate: BasePresenterDelegate {
}

class CardListScreenPresenter {
    
    weak var delegate: CardListScreenPresenterDelegate?
    let router: CardListScreenRouter
    
    var currentCards: [Card]?
    
    init(delegate: CardListScreenPresenterDelegate, router: CardListScreenRouter) {
        self.delegate = delegate
        self.router = router
    }
    
    func didLoad() {
    }
    
    func willAppear() {
    }
    
    func didAppear() {
    }
    
    func navigateToCardDetail(cardId: String) {
        router.navigateToCardDetail(cardId: cardId)
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
}
