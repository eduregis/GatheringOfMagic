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
    
    
    var isDeckCard: Bool?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cardName: UILabel!
    
    func configure(with card: Card, isDeckCard: Bool) {
        
        imageView.image = UIImage(named: "backside")
        
        self.card = card
        
        guard let imageUrlString = card.imageUrl else { return }
        
        guard let imageUrl = URL(string: imageUrlString) else { return }
        
        imageView.load(url: imageUrl)
        
        self.cardName.text = card.name
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        cardName.text = ""
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
        URLSession.shared.downloadTask(with: url) { [weak self] url, _, error in
            guard
                let cache = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first,
                let url = url
                else {
                    return
            }
            
            do {
                let file = cache.appendingPathComponent("\(UUID().uuidString).jpg")
                try FileManager.default.moveItem(atPath: url.path,
                                                 toPath: file.path)
                DispatchQueue.main.async {
                    self?.image = UIImage(contentsOfFile: file.path)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
        
    }
}
