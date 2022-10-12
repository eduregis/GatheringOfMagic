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
    title.font = UIFont(name: "Helvetica-Bold", size: 20)
    title.textColor = .gray
    title.translatesAutoresizingMaskIntoConstraints = false
    return title
}()

func setupHeaderViews()   {
    addSubview(typeLabel)

    typeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
    typeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5).isActive = true
    typeLabel.widthAnchor.constraint(equalToConstant: 240).isActive = true
    typeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
}


required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}
}
