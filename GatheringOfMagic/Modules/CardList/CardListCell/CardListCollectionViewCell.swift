//
//  CardListCollectionViewCell.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 05/10/22.
//

import UIKit
import SDWebImage

class CardListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var favoriteStar: UIImageView!
    @IBOutlet weak var strokeFavoriteStar: UIImageView!
    
    
    var currentCard: Card?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        favoriteStar.isHidden = true
        strokeFavoriteStar.isHidden = true
        cardName.numberOfLines = 0
        cardName.lineBreakMode = .byTruncatingTail
    }
    
    func fill(name: String?, imageURL: String?, isFavorited: Bool = false) {
        cardName.text = name
        if let imageURL = imageURL {
            cardImage.sd_setImage(with: URL(string: imageURL.protocolAPS()), placeholderImage: UIImage(named: "backCard.png"))
            cardImage.layer.cornerRadius = 10
            indicator.stopAnimating()
            favoriteStar.isHidden = !isFavorited
            strokeFavoriteStar.isHidden = !isFavorited
        }
        
    }
}
