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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardNameLabel.text = card?.name
        
        cardRarityLabel.text = card?.rarity
        cardPowerToughnessLabel.text = "\(card?.power ?? "NA")/\(card?.toughness ?? "NA")"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
