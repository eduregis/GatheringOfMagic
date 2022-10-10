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
    @IBOutlet weak var quantityLabel: UILabel!
    
    var currentCard: Card?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        favoriteStar.isHidden = true
        strokeFavoriteStar.isHidden = true
        cardName.numberOfLines = 0
        cardName.lineBreakMode = .byTruncatingTail
        quantityLabel.isHidden = true
    }
    
    func fill(name: String?, imageURL: String?, isFavorited: Bool = false, quantity: Int = 1) {
        cardName.text = name
        if let imageURL = imageURL {
            cardImage.sd_setImage(with: URL(string: imageURL.protocolAPS()), placeholderImage: UIImage(named: "backCard.png"))
            cardImage.layer.cornerRadius = 10
            indicator.stopAnimating()
            favoriteStar.isHidden = !isFavorited
            strokeFavoriteStar.isHidden = !isFavorited
        }
        setQuantity(quantity: quantity)
    }
    
    func setQuantity(quantity: Int) {
        if (quantity > 1) {
            quantityLabel.isHidden = false
            quantityLabel.text = "\(quantity)"
            quantityLabel.backgroundColor = .white
            quantityLabel.textColor = .systemBlue
            quantityLabel.layer.borderWidth = 3
            quantityLabel.layer.borderColor = UIColor.systemBlue.cgColor
            quantityLabel.layer.cornerRadius = 3
            quantityLabel.clipsToBounds = true
            
        }
    }
}
