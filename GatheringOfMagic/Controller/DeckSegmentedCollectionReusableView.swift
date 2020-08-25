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
    
    var value: Int = 0
    
    @IBOutlet weak var capacity: UILabel!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
//    @IBAction func segmentedControl(_ sender: Any) {
//        switch segmentedControl.selectedSegmentIndex {
//        case 0:
//        UserDefaults.standard.set("Mainboard", forKey: "mainOrSide")
//        case 1:
//        UserDefaults.standard.set("Sideboard", forKey: "mainOrSide")
//        default: break
//        }
//    }
}
