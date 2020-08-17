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
    
    var favoriteCards = Database.shared.loadData(from: .favoriteCards)
    
    var favoriteButton: UIButton?
    var favoriteImage: UIImage?
    var isFavorite: Bool = false
    
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardRarityLabel: UILabel!
    @IBOutlet weak var cardPowerToughnessLabel: UILabel!
    @IBOutlet weak var cardSetButton: UIButton!
    @IBOutlet weak var cardArtistLabel: UILabel!
    @IBOutlet weak var cardTypesLabel: UILabel!
    @IBOutlet weak var cardTextLabel: UILabel!
    @IBOutlet weak var cardFlavorLabel: UILabel!
    @IBOutlet var cardManaCostCollection: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Card"
        
        cardNameLabel.text = card?.name
        
        guard let imageUrlString = card?.imageUrl else { return }
        
        guard let imageUrl = URL(string: imageUrlString) else { return }
        
        cardImageView.load(url: imageUrl)
        
        cardRarityLabel.text = card?.rarity
        
        cardPowerToughnessLabel.text = "\(card?.power ?? "NA")/\(card?.toughness ?? "NA")"
        
        cardSetButton.setTitle(card?.set, for: .normal)
        
        cardArtistLabel.text = card?.artist
        
        cardTypesLabel.text = card?.type
        
        cardTextLabel.text = card?.text
        cardTextLabel.numberOfLines = 0
        
        cardFlavorLabel.text = card?.flavor
        cardFlavorLabel.numberOfLines = 0
        
        
        if (card?.manaCost) != nil {
            
            if var manaCosts = card?.manaCost?.components(separatedBy: "}") {
                for i in 0..<manaCosts.count - 1 {
                    manaCosts[i] = "\(manaCosts[i])}"
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
        
        setupNavigationItemBar()
        
    }
    
    func setupNavigationItemBar() {
        if favoriteCards.firstIndex(of: card!) != nil {
            isFavorite = true
        }
        if isFavorite {
            favoriteImage = UIImage(named: "star-fill")
        } else {
            favoriteImage = UIImage(named: "star-empty")
        }
        
        favoriteButton = UIButton(type: .system)
        favoriteButton?.setImage(favoriteImage? .withRenderingMode(.alwaysOriginal), for: .normal)
        favoriteButton?.widthAnchor.constraint(equalToConstant: 34).isActive = true
        favoriteButton?.heightAnchor.constraint(equalToConstant: 34).isActive = true
        favoriteButton?.contentMode = .center
        favoriteButton?.addTarget(self, action: #selector(isFavorited), for: UIControl.Event.touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favoriteButton!)
    }
    
    @objc func isFavorited() {
        if isFavorite {
            favoriteImage = UIImage(named: "star-empty")
            //Database.shared.deleteAllCards(from: .favoriteCards)
            Database.shared.deleteCard(from: .favoriteCards, at: card!)
        } else {
            favoriteImage = UIImage(named: "star-fill")
            favoriteCards.append(card!)
            Database.shared.saveData(from: favoriteCards, to: .favoriteCards)
        }
        favoriteCards = Database.shared.loadData(from: .favoriteCards)
        isFavorite = !isFavorite
        
        favoriteButton?.setImage(favoriteImage? .withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    @IBAction func cardSetButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "SetViewSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SetViewController {
            let vc = segue.destination as? SetViewController
            vc?.setCode = card?.set
        }
    }
}
