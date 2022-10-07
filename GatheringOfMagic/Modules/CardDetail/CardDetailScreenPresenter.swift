//
//  CardDetailScreenPresenter.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 05/10/22.
//

import UIKit
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
    
    func favoriteCard() {
        if let card = currentCard, card.id != nil  {
            
            guard let deck = DataManager.shared.getDeckByName(name: "Favorites") else { return }
            
            var cards = [CD_CardDetail]()
            
            var cardDetail = DataManager.shared.createCard(
                artist: card.artist ?? "",
                cmc: Int32(card.cmc ?? 0),
                id: card.id ?? "",
                imageUrl: card.imageUrl ?? "",
                manaCost: card.manaCost ?? "",
                name: card.name ?? "",
                power: card.power ?? "",
                rarity: card.rarity ?? "",
                toughness: card.toughness ?? "",
                type: card.type ?? "",
                deck: deck)
            
            cards.append(cardDetail)
            
            DataManager.shared.save()
            
//            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//            
//            let managedContext = appDelegate.persistentContainer.viewContext
//            
//            let cardEntity = NSEntityDescription.entity(forEntityName: "CD_CardDetail", in: managedContext)!
//            let cd_CardDetail = NSManagedObject(entity: cardEntity, insertInto: managedContext)
//            
//            let coreDataMethods = CoreDataMethods()
//            
//            let favoritesResult = coreDataMethods.fetchRecordsForEntity(
//                "CD_Deck",
//                inManagedObjectContext: managedContext,
//                predicates: ["name LIKE %@" : "Favorites"]
//            ).first
//            
//            cd_CardDetail.setValue(card.artist, forKey: "artist")
//            cd_CardDetail.setValue(card.cmc, forKey: "cmc")
//            cd_CardDetail.setValue(card.id, forKey: "id")
//            cd_CardDetail.setValue(card.imageUrl, forKey: "imageUrl")
//            cd_CardDetail.setValue(card.manaCost, forKey: "manaCost")
//            cd_CardDetail.setValue(card.name, forKey: "name")
//            cd_CardDetail.setValue(card.power, forKey: "power")
//            cd_CardDetail.setValue(card.rarity, forKey: "rarity")
//            cd_CardDetail.setValue(card.toughness, forKey: "toughness")
//            cd_CardDetail.setValue(card.type, forKey: "type")
//            
//            guard let favoriteCards = favoritesResult else { return }
//            
//            let cards = favoriteCards.mutableSetValue(forKey: "cards")
//            cards.add(cd_CardDetail)
//            
//            do {
//                try managedContext.save()
//            } catch let error as NSError {
//                print("erro ao salvar: \(error)")
//            }
        }
        
        
    }
}
