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
    @IBOutlet weak var stackOfColors: UIStackView!
    
    override func prepareForReuse() {
        deckName.text = ""
        mainboardCapacity.text = "-/-"
        sideboardCapacity.text = "-/-"
    }
    
    var colors: [String]?
    
    @IBOutlet var deckManaCostCollection: [UIImageView]!
    
    func configure(with deck: Deck) {
        self.deck = deck
        
        deckName.text = self.deck?.name
        
        deckManaCostCollection.forEach { $0.image = nil }
        
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
        
        colors = []
        
        deck.main.deckCards.forEach {
            colors!.append(contentsOf: $0.card.colors)
        }
        colors = Array(Set(colors!))
        
        deckColors(colors: colors!)
        
        constraintsForStackView()
    }
    
    func constraintsForStackView() {
        stackOfColors?.translatesAutoresizingMaskIntoConstraints = false
        stackOfColors.spacing = 5
        stackOfColors.axis = .horizontal
        stackOfColors.distribution = .fillEqually
        stackOfColors.alignment = .fill
        
        let verticalSpacingToNameLabel = NSLayoutConstraint(item: stackOfColors!, attribute: .bottom, relatedBy: .equal, toItem: deckName, attribute: .bottom, multiplier: 1, constant: -25)
        verticalSpacingToNameLabel.isActive = true
        let leadingToSuperView = NSLayoutConstraint(item: stackOfColors!, attribute: .leading, relatedBy: .equal, toItem: mainboardCapacity, attribute: .leading, multiplier: 1, constant: CGFloat(45 - (colors?.count ?? 0)*12))
        leadingToSuperView.isActive = true
    }
    
    func deckColors(colors: [String]) {
        if colors.count > 0 {
            for index in 0..<colors.count {
                switch colors[index] {
                case "0":
                    deckManaCostCollection[index].image = UIImage(named: "incolor-0")
                case "1":
                    deckManaCostCollection[index].image = UIImage(named: "incolor-1")
                case "2":
                    deckManaCostCollection[index].image = UIImage(named: "incolor-2")
                case "3":
                    deckManaCostCollection[index].image = UIImage(named: "incolor-3")
                case "4":
                    deckManaCostCollection[index].image = UIImage(named: "incolor-4")
                case "5":
                    deckManaCostCollection[index].image = UIImage(named: "incolor-5")
                case "6":
                    deckManaCostCollection[index].image = UIImage(named: "incolor-6")
                case "7":
                    deckManaCostCollection[index].image = UIImage(named: "incolor-7")
                case "8":
                    deckManaCostCollection[index].image = UIImage(named: "incolor-8")
                case "9":
                    deckManaCostCollection[index].image = UIImage(named: "incolor-9")
                case "10":
                    deckManaCostCollection[index].image = UIImage(named: "incolor-10")
                case "11":
                    deckManaCostCollection[index].image = UIImage(named: "incolor-11")
                case "12":
                    deckManaCostCollection[index].image = UIImage(named: "incolor-12")
                case "13":
                    deckManaCostCollection[index].image = UIImage(named: "incolor-13")
                case "14":
                    deckManaCostCollection[index].image = UIImage(named: "incolor-14")
                case "15":
                    deckManaCostCollection[index].image = UIImage(named: "incolor-15")
                case "16":
                    deckManaCostCollection[index].image = UIImage(named: "incolor-16")
                case "17":
                    deckManaCostCollection[index].image = UIImage(named: "incolor-17")
                case "18":
                    deckManaCostCollection[index].image = UIImage(named: "incolor-18")
                case "19":
                    deckManaCostCollection[index].image = UIImage(named: "incolor-19")
                case "20":
                    deckManaCostCollection[index].image = UIImage(named: "incolor-20")
                case "White":
                    deckManaCostCollection[index].image = UIImage(named: "white")
                case "Blue":
                    deckManaCostCollection[index].image = UIImage(named: "blue")
                case "Black":
                    deckManaCostCollection[index].image = UIImage(named: "black")
                case "Red":
                    deckManaCostCollection[index].image = UIImage(named: "red")
                case "Green":
                    deckManaCostCollection[index].image = UIImage(named: "green")
                default:
                    deckManaCostCollection[index].image = UIImage(named: "incolor-0")
                }
            }
        }
    }
    
    override func layoutSubviews() {
        deckName.lineBreakMode = .byWordWrapping
        deckName.numberOfLines = 0
    }
    
    static func xibForCollection() -> UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
}
