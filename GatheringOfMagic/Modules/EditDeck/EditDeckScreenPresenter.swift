//
//  EditDeckScreenPresenter.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 12/10/22.
//

import Foundation

protocol EditDeckScreenPresenterDelegate: BasePresenterDelegate {
}

class EditDeckScreenPresenter {
    
    var deck: CD_Deck?
    var name: String? = ""
    var format: String? = ""
    
    let tableViewInfos: [String] = [
        "Deck name: ",
        "Deck format: "
    ]
    
    weak var delegate: EditDeckScreenPresenterDelegate?
    let router: EditDeckScreenRouter
    
    init(deck: CD_Deck, delegate: EditDeckScreenPresenterDelegate, router: EditDeckScreenRouter) {
        self.deck = deck
        self.name = deck.name
        self.format = deck.format
        self.delegate = delegate
        self.router = router
    }
    
    func didLoad() {
    }
    
    func willAppear() {
    }
    
    func didAppear() {
    }
    
    func formatForDeck(format: DeckFormats) -> String {
        switch (format) {
        case .vintage:
            return "Vintage"
        case .commander:
            return "Commander"
        case .standard:
            return "Standard"
        }
    }
    
}
