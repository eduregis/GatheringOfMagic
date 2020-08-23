//
//  DecksViewController.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 20/08/20.
//  Copyright © 2020 Eduardo Oliveira. All rights reserved.
//

import UIKit

class DecksViewController: UICollectionViewController {
    
    private let itemsPerRow: CGFloat = 2
    
    private var timerCount: Int = 0
    
    private let sectionInsets = UIEdgeInsets(top: 50.0,
                                             left: 20.0,
                                             bottom: 50.0,
                                             right: 20.0)
    
    var selectedDeck: Deck?
    
    var listOfDecks = [Deck]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    @IBAction func newDeck(_ sender: Any) {
        let newDeck = Deck()
        listOfDecks.append(newDeck)
        //listOfDecks.removeAll()
        Database.shared.saveData(from: listOfDecks, to: .deckList)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(DeckViewCell.xibForCollection(), forCellWithReuseIdentifier: DeckViewCell.identifier)
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DecksCell")
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchDecks()
    }
    
    func fetchDecks () {
        listOfDecks = Database.shared.loadData(from: .deckList)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfDecks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeckViewCell.identifier, for: indexPath) as? DeckViewCell else { fatalError("Wrong identifier") }
        cell.configure(with: listOfDecks[indexPath.row])
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // criar xib personalizada
        // let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        self.selectedDeck = listOfDecks[indexPath.row]
        performSegue(withIdentifier: "DeckViewSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DeckViewController {
            let vc = segue.destination as? DeckViewController
            vc?.deck = selectedDeck
        }
    }
}

extension DecksViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: 3*widthPerItem/2)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
