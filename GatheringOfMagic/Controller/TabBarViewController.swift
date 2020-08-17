//
//  TabBarViewController.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 17/08/20.
//  Copyright © 2020 Eduardo Oliveira. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
          self.tabBar.barTintColor = UIColor.red
          self.tabBar.unselectedItemTintColor = UIColor.darkGray
          self.tabBar.tintColor = UIColor.white
    }
}
