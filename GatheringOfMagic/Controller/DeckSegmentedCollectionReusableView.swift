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
    
    @IBOutlet weak var capacity: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
}
