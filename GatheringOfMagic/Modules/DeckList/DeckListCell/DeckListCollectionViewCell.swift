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
    @IBOutlet weak var overlay: UIView!
    
    @IBOutlet var collectionOfManaCostIcons: Array<UIImageView>?

    @IBOutlet weak var manaCostXConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clear()
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        deckName.numberOfLines = 0
        deckName.lineBreakMode = .byTruncatingTail
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
        let cards = DataManager.shared.getCards(deck: currentDeck)
        
        deckName.text = "\(currentDeck.name ?? "") (\(totalCardsInDeck(cards: cards)))"
        
        setManaIcons(cards: cards)
        if let imageURL = currentDeck.coverId {
            deckImage.sd_setImage(with: URL(string: imageURL.protocolAPS()), placeholderImage: UIImage(named: "placeholderDeck.png"))
            deckImage.backgroundColor = .systemGray
            deckImage.contentMode = .top
            deckImage.layer.contentsRect = CGRect(x: 0.1, y: 0.15, width: 0.75, height: 0.75)
            deckImage.layer.cornerRadius = 10
            overlay.layer.cornerRadius = 10
            indicator.stopAnimating()
        }
    }
    
    func totalCardsInDeck(cards: [CD_CardDetail]) -> Int {
        var totalCount = 0
        for card in cards {
            totalCount += Int(card.quantity)
        }
        return totalCount
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

extension UIImage {
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
