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
    
    init(delegate: CardListScreenPresenterDelegate, router: CardListScreenRouter) {
        self.delegate = delegate
        self.router = router
    }
    
    func didLoad() {
    }
    
    func willAppear() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let coreDataMethods = CoreDataMethods()
        
        let deckResult = coreDataMethods.fetchRecordsForEntity(
            "CD_Deck",
            inManagedObjectContext: managedContext,
            predicates: ["name LIKE %@" : "Favorites"]
        ).first
        
        let cardResults = coreDataMethods.fetchRecordsForEntity(
            "CD_CardDetail",
            inManagedObjectContext: managedContext,
            predicates: [:]
        )
        
        guard let favoriteList = deckResult else { return }

        print("-------DECKS-------")
        print(favoriteList.value(forKey: "name"))
        print(favoriteList.value(forKey: "format"))
        let cards = favoriteList.value(forKey: "cards") as? [NSManagedObject]
        
        print(cards?.count)
        
        
//        print("-------CARDS-------")
//        for card in cardResults {
//            print(card.value(forKey: "name"), " , ", card.value(forKey: "power"))
//        }
        
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
