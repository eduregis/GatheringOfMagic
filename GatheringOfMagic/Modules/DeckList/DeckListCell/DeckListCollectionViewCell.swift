//
//  DeckListCollectionViewCell.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 08/10/22.
//


import UIKit
import SDWebImage

class DeckListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var deckImage: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var deckName: UILabel!
    
    var currentDeck: CD_Deck?

    override func awakeFromNib() {
        super.awakeFromNib()
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
    }
    
    func fill(name: String?, imageURL: String?, isFavorited: Bool = false) {
        deckName.text = name
        if let imageURL = imageURL {
            deckImage.sd_setImage(with: URL(string: imageURL.protocolAPS()), placeholderImage: UIImage(named: "placeholderDeck.png"))
            deckImage.backgroundColor = .systemGray
            deckImage.layer.cornerRadius = 10
            indicator.stopAnimating()
        }
        
    }
}
