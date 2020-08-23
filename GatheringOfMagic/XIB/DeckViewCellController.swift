//
//  DeckViewCell.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 23/08/20.
//  Copyright © 2020 Eduardo Oliveira. All rights reserved.
//

import UIKit

class DeckViewCell: UICollectionViewCell {
    
    static let nibName = "DeckViewCell"
    static let identifier = "CardCell"
    
    var deck: Deck?
    
    @IBOutlet weak var deckName: UILabel!
    @IBOutlet weak var mainboardCapacity: UILabel!
    @IBOutlet weak var sideboardCapacity: UILabel!
    
    override func prepareForReuse() {
        deckName.text = ""
        mainboardCapacity.text = "-/-"
        sideboardCapacity.text = "-/-"
    }
    
    func configure(with deck: Deck) {
        self.deck = deck
        
        deckName.text = self.deck?.name
        
        var mainboardCount = 0
        self.deck?.main.deckCards.forEach {
             mainboardCount += $0.quantity
        }
        mainboardCapacity.text = "\(mainboardCount)/60"
        
        var sideboardCount = 0
        self.deck?.sideboard.deckCards.forEach {
             sideboardCount += $0.quantity
        }
        sideboardCapacity.text = "\(sideboardCount)/15"
        
    }
    
    override func layoutSubviews() {
        deckName.lineBreakMode = .byWordWrapping
        deckName.numberOfLines = 0
    }
    
    static func xibForCollection() -> UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
}
