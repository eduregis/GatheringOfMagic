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
    let isComingFromTabBar: Bool?
    
    var decks: [CD_Deck]?
    // Add to Card from Card detail Screen
    var cardToAddInDeck: CardDetail?
    
    init(delegate: DeckListScreenPresenterDelegate, router: DeckListScreenRouter, isComingFromTabBar: Bool, cardToAddInDeck: CardDetail? = nil) {
        self.delegate = delegate
        self.router = router
        self.isComingFromTabBar = isComingFromTabBar
        self.cardToAddInDeck = cardToAddInDeck
    }
    
    func didLoad() {
    }
    
    func willAppear() {
    }
    
    func didAppear() {
    }
    
    func updateDecks() {
        self.decks = DataManager.shared.getDecks().filter {$0.format != "Favorites"}
    }
    
    func loadDecks(completion: @escaping () -> Void) {
        
        delegate?.showLoader()
        
        DispatchQueue.main.async {
            self.updateDecks()
            self.delegate?.hideLoader()
            completion()
        }
    }
    
    func navigateToDeckDetail(deck: CD_Deck, completion: (() -> Void)?) {
        router.navigateToDeckDetail(deck: deck, completion: completion)
    }
    
    func addToDeck(deck: CD_Deck) -> (Bool, String) {
        if let card = cardToAddInDeck, card.id != nil  {
            var cards = DataManager.shared.getCards(deck: deck)
            
            let cardThatAlreadyExistsInDeck = cards.filter{ $0.id == card.id }.first

            
            if let appendToCard = cardThatAlreadyExistsInDeck {
                if (appendToCard.quantity == 4) {
                    if let isBasicLand = card.type?.contains("Basic Land"), (isBasicLand == false) {
                        return (false, AddToDeckScreenTexts.maxNumberOfCopies.localized())
                    }
                }
                appendToCard.quantity += 1
            } else {
                let cardDetail = DataManager.shared.createCard(
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
            }
            
            DataManager.shared.save()
            return (true, "")
        }
        return (false, AddToDeckScreenTexts.nilCard.localized())
    }
}
