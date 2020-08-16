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
        
        guard let imageUrl = URL(string: imageUrlString) else { return }
        
        imageView.load(url: imageUrl)
        
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

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
