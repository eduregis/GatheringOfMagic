//
//  DeckDetailCollectionViewHeader.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 09/10/22.
//

import UIKit

class DeckDetailCollectionViewHeader: UICollectionViewCell  {

override init(frame: CGRect) {
    super.init(frame: frame)
    setupHeaderViews()
}

let typeLabel: UILabel = {
    let title = UILabel()
    title.font = UIFont(name: "Montserrat", size: 17)
    title.textColor = .gray
    title.translatesAutoresizingMaskIntoConstraints = false
    return title
}()

func setupHeaderViews()   {
    addSubview(typeLabel)

    typeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
    typeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
    typeLabel.widthAnchor.constraint(equalToConstant: 240).isActive = true
    typeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
}


required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}
}
