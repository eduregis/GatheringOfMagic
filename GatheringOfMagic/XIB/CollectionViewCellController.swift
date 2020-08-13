//
//  CollectionViewCellController.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 12/08/20.
//  Copyright © 2020 Eduardo Oliveira. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    static let nibName = "CollectionViewCell"
    static let identifier = "CardCell"
    
    var card: Card?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cardName: UILabel!
    
    func configure(with card: Card) {
        
        self.card = card
        
        guard let imageUrlString = card.imageUrl else { return }
        
        guard let imageURL = URL(string: imageUrlString) else { return }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
        
        self.cardName.text = card.name
    }
    
    override func layoutSubviews() {
        cardName.lineBreakMode = .byWordWrapping
        cardName.numberOfLines = 0
    }
    
    static func xibForCollection() -> UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
}
