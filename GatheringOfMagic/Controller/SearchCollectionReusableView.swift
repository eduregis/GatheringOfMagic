//
//  SeachCollectionReusableView.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 14/08/20.
//  Copyright © 2020 Eduardo Oliveira. All rights reserved.
//

import UIKit

class SearchCollectionReusableView: UICollectionReusableView {
        
    static let nibName = "SearchCollectionReusableView"
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var filterButton: UIButton!
}
