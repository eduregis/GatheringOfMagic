//
//  DeckViewController.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 20/08/20.
//  Copyright © 2020 Eduardo Oliveira. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class DeckViewController: UICollectionViewController {
    
    var deck: Deck? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private let itemsPerRow: CGFloat = 3
    
    private var timerCount: Int = 0
    
    private let sectionInsets = UIEdgeInsets(top: 50.0,
                                             left: 20.0,
                                             bottom: 50.0,
                                             right: 20.0)
    
    weak var header: DeckSegmentedCollectionReusableView?
    
    var mainOrSide: String? {
        didSet {
            DispatchQueue.main.async {
               self.collectionView.reloadItems(at: self.collectionView.indexPathsForVisibleItems)
            }
        }
    }
    
    var selectedCard: Card?
    
    var listOfDecks = [Deck]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = deck?.name
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(CollectionViewCell.xibForCollection(), forCellWithReuseIdentifier: CollectionViewCell.identifier)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
        }
        
        initValues()
    }
    
    func initValues () {
        mainOrSide = "Mainboard"
    }
    
    @objc func changeValue () {
        if mainOrSide == "Mainboard" {
            mainOrSide = "Sideboard"
        } else {
            mainOrSide = "Mainboard"
        }
        self.collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchDecks()
        let index = listOfDecks.firstIndex {$0.index == deck?.index }
        if let index = index {
            deck = listOfDecks[index]
        }
    }
    
    func fetchDecks () {
        listOfDecks = Database.shared.loadData(from: .deckList)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch mainOrSide {
        case "Mainboard":
            return (deck?.main.deckCards.count)!
        case "Sideboard":
            return (deck?.sideboard.deckCards.count)!
        default:
            return 0
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else { fatalError("Wrong identifier") }
        
        var quantity: Int?
        switch mainOrSide {
        case "Mainboard":
            quantity = deck?.main.deckCards[indexPath.row].quantity ?? 0
            cell.configure(with: deck?.main.deckCards[indexPath.row].card ?? Card())
        case "Sideboard":
            quantity = deck?.sideboard.deckCards[indexPath.row].quantity ?? 0
            cell.configure(with: deck?.sideboard.deckCards[indexPath.row].card ?? Card())
        default:
            quantity = 0
        }
        
        let copyLabel = UILabel(frame: CGRect(x: cell.contentView.frame.width/2 - 20, y: cell.imageView.frame.midY + 105, width: 20, height: 20))
        
        copyLabel.text = "\(quantity ?? 0)"
        
        cell.contentView.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        let addButton = UIButton(frame: CGRect(x: cell.contentView.frame.width/2 + 5, y: cell.imageView.frame.midY + 105, width: 20, height: 20))
        let addImage = UIImage(named: "chevron-right")
        addButton.setImage(addImage, for: .normal)
        let addTapGesture = DeckEditTapGestureRecognizer(target: self,
                                                         action: #selector(addCard(sender:)))
        addTapGesture.index = indexPath.row
        addTapGesture.actualQuantity = quantity
        addButton.addGestureRecognizer(addTapGesture)
        cell.contentView.addSubview(addButton)
        
        let subtractButton = UIButton(frame: CGRect(x: cell.contentView.frame.width/2 - 55, y: cell.imageView.frame.midY + 105, width: 20, height: 20))
        let subtractImage = UIImage(named: "chevron-left")
        subtractButton.setImage(subtractImage, for: .normal)
        let subtractTapGesture = DeckEditTapGestureRecognizer(target: self,
                                                              action: #selector(subtractCard(sender:)))
        subtractTapGesture.index = indexPath.row
        subtractTapGesture.actualQuantity = quantity
        subtractButton.addGestureRecognizer(subtractTapGesture)
        cell.contentView.addSubview(subtractButton)
        
        cell.contentView.addSubview(copyLabel)
        
        return cell
    }
    
    @objc func addCard (sender: DeckEditTapGestureRecognizer) {
        if let index = sender.index {
            if let actualQuantity = sender.actualQuantity {
                switch mainOrSide {
                case "Mainboard":
                    switch actualQuantity {
                    case 4:
                        if (deck?.main.deckCards[index].card.type.contains("Basic Land"))! {
                            
                            deck?.main.deckCards[index].quantity = actualQuantity + 1
                        }
                    default:
                        deck?.main.deckCards[index].quantity = actualQuantity + 1
                    }
                case "Sideboard":
                    switch actualQuantity {
                    case 4:
                        if (deck?.sideboard.deckCards[index].card.type.contains("Basic Land"))! {
                            
                            deck?.sideboard.deckCards[index].quantity = actualQuantity + 1
                        }
                    default:
                        deck?.sideboard.deckCards[index].quantity = actualQuantity + 1
                    }
                default: break
                }
                
            }
        }
    }
    
    @objc func subtractCard (sender: DeckEditTapGestureRecognizer) {
        if let index = sender.index {
            if let actualQuantity = sender.actualQuantity {
                switch mainOrSide {
                case "Mainboard":
                    switch actualQuantity {
                    case 1:
                        deck?.main.deckCards.remove(at: index)
                    default:
                        deck?.main.deckCards[index].quantity = actualQuantity - 1
                    }
                case "Sideboard":
                    switch actualQuantity {
                    case 1:
                        deck?.sideboard.deckCards.remove(at: index)
                    default:
                        deck?.sideboard.deckCards[index].quantity = actualQuantity - 1
                    }
                default: break
                }
                
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        self.selectedCard = cell.card
        performSegue(withIdentifier: "CardViewSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is GatheringViewController {
            let vc = segue.destination as? GatheringViewController
            vc?.deck = deck
            vc?.deckComponent = mainOrSide
        }
        if segue.destination is CardViewController {
            let vc = segue.destination as? CardViewController
            vc?.card = selectedCard
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionViewHeader", for: indexPath) as? DeckSegmentedCollectionReusableView
            header?.segmentedControl.addTarget(self, action: #selector(changeValue), for: .valueChanged)
            if let mainOrSide = mainOrSide {
                var count = 0
                if mainOrSide == "Mainboard" {
                    deck?.main.deckCards.forEach { count += $0.quantity }
                    header?.capacity.text = "\(count)/60"
                } else if mainOrSide == "Sideboard" {
                    deck?.sideboard.deckCards.forEach { count += $0.quantity }
                    header?.capacity.text = "\(count)/15"
                }
            }
            return header!
        }
        return UICollectionReusableView()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let oldDeckIndex = listOfDecks.firstIndex { $0.index == deck?.index }
        if let oldDeckIndex = oldDeckIndex {
            if let deck = deck {
                listOfDecks[oldDeckIndex] = deck
                Database.shared.saveData(from: listOfDecks, to: .deckList)
            }
        }
    }
}

extension DeckViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: 2*widthPerItem)
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
