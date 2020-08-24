//
//  DeckSegmentedCollectionReusableView.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 23/08/20.
//  Copyright © 2020 Eduardo Oliveira. All rights reserved.
//

import UIKit

class DeckSegmentedCollectionReusableView: UICollectionReusableView {
    static let nibName = "DeckSegmentedCollectionReusableView"
    
    var mainOrSide: String?
    
    @IBOutlet weak var capacity: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func segmentedControl(_ sender: Any) {
        print(mainOrSide)
        switch segmentedControl.selectedSegmentIndex {
        case 0: mainOrSide = "Mainboard"
        case 1: mainOrSide = "Sideboard"
        default: break
        
        }
    }
}
