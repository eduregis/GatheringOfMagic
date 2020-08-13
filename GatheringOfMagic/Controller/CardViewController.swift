//
//  CardViewController.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 13/08/20.
//  Copyright © 2020 Eduardo Oliveira. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    var card: Card?
    
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardRarityLabel: UILabel!
    @IBOutlet weak var cardPowerToughnessLabel: UILabel!
    @IBOutlet weak var cardSetLabel: UILabel!
    @IBOutlet var cardManaCostCollection: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardNameLabel.text = card?.name
        
        cardRarityLabel.text = card?.rarity
        
        cardPowerToughnessLabel.text = "\(card?.power ?? "NA")/\(card?.toughness ?? "NA")"
        
        if (card?.manaCost) != nil {
            
            if var manaCosts = card?.manaCost?.components(separatedBy: "}") {
                for i in 0..<manaCosts.count - 1 {
                    manaCosts[i] = "\(manaCosts[i])}"
                    print(manaCosts[i])
                    switch manaCosts[i] {
                    case "{0}":
                        cardManaCostCollection[i].image = UIImage(named: "incolor-0")
                    case "{1}":
                        cardManaCostCollection[i].image = UIImage(named: "incolor-1")
                    case "{2}":
                        cardManaCostCollection[i].image = UIImage(named: "incolor-2")
                    case "{3}":
                        cardManaCostCollection[i].image = UIImage(named: "incolor-3")
                    case "{4}":
                        cardManaCostCollection[i].image = UIImage(named: "incolor-4")
                    case "{5}":
                        cardManaCostCollection[i].image = UIImage(named: "incolor-5")
                    case "{6}":
                        cardManaCostCollection[i].image = UIImage(named: "incolor-6")
                    case "{7}":
                        cardManaCostCollection[i].image = UIImage(named: "incolor-7")
                    case "{8}":
                        cardManaCostCollection[i].image = UIImage(named: "incolor-8")
                    case "{9}":
                        cardManaCostCollection[i].image = UIImage(named: "incolor-9")
                    case "{10}":
                        cardManaCostCollection[i].image = UIImage(named: "incolor-10")
                    case "{11}":
                        cardManaCostCollection[i].image = UIImage(named: "incolor-11")
                    case "{12}":
                        cardManaCostCollection[i].image = UIImage(named: "incolor-12")
                    case "{13}":
                        cardManaCostCollection[i].image = UIImage(named: "incolor-13")
                    case "{14}":
                        cardManaCostCollection[i].image = UIImage(named: "incolor-14")
                    case "{15}":
                        cardManaCostCollection[i].image = UIImage(named: "incolor-15")
                    case "{16}":
                        cardManaCostCollection[i].image = UIImage(named: "incolor-16")
                    case "{17}":
                        cardManaCostCollection[i].image = UIImage(named: "incolor-17")
                    case "{18}":
                        cardManaCostCollection[i].image = UIImage(named: "incolor-18")
                    case "{19}":
                        cardManaCostCollection[i].image = UIImage(named: "incolor-19")
                    case "{20}":
                        cardManaCostCollection[i].image = UIImage(named: "incolor-20")
                    case "{W}":
                        cardManaCostCollection[i].image = UIImage(named: "white")
                    case "{U}":
                        cardManaCostCollection[i].image = UIImage(named: "blue")
                    case "{B}":
                        cardManaCostCollection[i].image = UIImage(named: "black")
                    case "{R}":
                        cardManaCostCollection[i].image = UIImage(named: "red")
                    case "{G}":
                        cardManaCostCollection[i].image = UIImage(named: "green")
                    default:
                        cardManaCostCollection[i].image = UIImage(named: "incolor-0")
                    }
                }
            }
        }
        
        
    }
}
