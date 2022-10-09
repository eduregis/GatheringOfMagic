//
//  DeckListCollectionViewCell.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 08/10/22.
//


import UIKit
import SDWebImage

class DeckListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var deckImage: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var deckName: UILabel!
    
    @IBOutlet var collectionOfManaCostIcons: Array<UIImageView>?

    @IBOutlet weak var manaCostXConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clear()
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
    }
    
    func clear() {
        guard let manaCostIcons = collectionOfManaCostIcons else { return }
        for manaCostIcon in manaCostIcons {
            manaCostIcon.image = nil
        }
    }
    
    func fill(deck: CD_Deck?, isFavorited: Bool = false) {
        clear()
        guard let currentDeck = deck else { return }
        deckName.text = currentDeck.name
        setManaIcons(cards: DataManager.shared.getCards(deck: currentDeck))
        if let imageURL = currentDeck.coverId {
            deckImage.sd_setImage(with: URL(string: imageURL.protocolAPS()), placeholderImage: UIImage(named: "placeholderDeck.png"))
            deckImage.backgroundColor = .systemGray
            deckImage.layer.cornerRadius = 10
            indicator.stopAnimating()
        }
    }
    
    func setManaIcons(cards: [CD_CardDetail]) {
        
        var manaColors: [String] = []
        
        if cards.contains(where: {$0.manaCost!.contains("B")}) { manaColors.append("mana_B") }
        if cards.contains(where: {$0.manaCost!.contains("G")}) { manaColors.append("mana_G") }
        if cards.contains(where: {$0.manaCost!.contains("R")}) { manaColors.append("mana_R") }
        if cards.contains(where: {$0.manaCost!.contains("U")}) { manaColors.append("mana_U") }
        if cards.contains(where: {$0.manaCost!.contains("W")}) { manaColors.append("mana_W") }
        
        guard let manaCostIcons = collectionOfManaCostIcons else { return }
        
        for (manaCostIcon, manaColor) in zip(manaCostIcons, manaColors) {
            manaCostIcon.image = UIImage(named: manaColor)
        }
        
        manaCostXConstraint.constant = CGFloat((manaColors.count - 1) * -13)
    }
}
