//
//  CardDetailScreenPresenter.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 05/10/22.
//

import Foundation
import CoreData

protocol CardDetailScreenPresenterDelegate: BasePresenterDelegate {
}

class CardDetailScreenPresenter {
    
    let cardId: String?
    weak var delegate: CardDetailScreenPresenterDelegate?
    let router: CardDetailScreenRouter
    var currentCard: CardDetail?
    
    init(cardId: String, delegate: CardDetailScreenPresenterDelegate, router: CardDetailScreenRouter) {
        self.cardId = cardId
        self.delegate = delegate
        self.router = router
        currentCard = CardDetail()
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
        delegate?.showLoader()
        
        guard let cardId = cardId else { return }
        
        VehicleDAO.getCardById(
            cardId: cardId,
            success: { card in
                self.currentCard = card
                self.delegate?.hideLoader()
                completion()
                
            }) { error in
                self.delegate?.hideLoader()
                self.delegate?.showMessage("erro, localized")
                DispatchQueue.main.async {
                    completion()
                }
            }
    }
}
