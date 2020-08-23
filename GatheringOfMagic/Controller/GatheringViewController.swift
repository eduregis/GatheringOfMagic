//
//  GatheringViewControllerTableViewController.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 11/08/20.
//  Copyright © 2020 Eduardo Oliveira. All rights reserved.
//

import UIKit

class GatheringViewController: UICollectionViewController {
    
    private let itemsPerRow: CGFloat = 3
    
    private var timerCount: Int = 0
    
    private let sectionInsets = UIEdgeInsets(top: 50.0,
                                             left: 20.0,
                                             bottom: 50.0,
                                             right: 20.0)
    
    var deck: Deck? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    var listOfDecks = [Deck]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    var deckComponent: String?
    
    var selectedCard: Card?
    
    var listOfCards = [Card]() {
        didSet {
            // Essa função assíncrona recarrega a lista toda vez que a searchBar é acionada com um ENTER
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CollectionViewCell.xibForCollection(), forCellWithReuseIdentifier: CollectionViewCell.identifier)
        makeRequest()
        setupNavigationbarItems()
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
    
    override func viewWillDisappear(_ animated: Bool) {
        if deckComponent != nil {
            let oldDeckIndex = listOfDecks.firstIndex { $0.index == deck?.index }
            if let oldDeckIndex = oldDeckIndex {
                if let deck = deck {
                    listOfDecks[oldDeckIndex] = deck
                    Database.shared.saveData(from: listOfDecks, to: .deckList)
                }
            }
        }
    }
    
    func setupNavigationbarItems () {
        if deck != nil {
            self.title = deck?.name
        } else {
            let titleImageView = UIImageView(image: UIImage(imageLiteralResourceName: "GatheringOfMagic"))
            titleImageView.frame = CGRect(x: 0, y: 0, width: 92, height: 30)
            titleImageView.contentMode = .scaleAspectFit
            navigationItem.titleView = titleImageView
        }
    }
    
    func makeRequest () {
        let cardRequest = MTGRequest(typeOfRequest: .cards)
        cardRequest.getCards { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let cards):
                self?.listOfCards = cards
            }
        }
    }
    
    func makeRequest (name: String) {
        let cardRequest = MTGRequest(typeOfRequest: .cards, name: name)
        cardRequest.getCards { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let cards):
                self?.listOfCards = cards
            }
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfCards.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else { fatalError("Wrong identifier") }
        
        if deckComponent != nil {
            cell.configure(with: listOfCards[indexPath.row], isDeckCard:
                true)
            
            var quantity: Int?
            
            let copyLabel = UILabel(frame: CGRect(x: cell.contentView.frame.width/2 - 20, y: cell.imageView.frame.midY + 105, width: 20, height: 20))
            switch deckComponent {
            case "Mainboard":
                let deckCard = deck?.main.deckCards.filter { $0.card == listOfCards[indexPath.row] }
                if deckCard?.count == 0 {
                    quantity = 0
                } else {
                    quantity = deckCard?[0].quantity
                }
                copyLabel.text = "\(quantity ?? 0)"
            case "Sideboard":
                let deckCard = deck?.sideboard.deckCards.filter { $0.card == listOfCards[indexPath.row] }
                if deckCard?.count == 0 {
                    quantity = 0
                } else {
                    quantity = deckCard?[0].quantity
                }
                copyLabel.text = "\(quantity ?? 0)"
            default:
                break
            }
            
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
            cell.contentView.addSubview(subtractButton)
            
            cell.contentView.addSubview(copyLabel)
        } else {
            cell.configure(with: listOfCards[indexPath.row], isDeckCard: false)
        }
        
        return cell
    }
    
    @objc func segueCard () {
        print("ativa segue")
    }
    
    @objc func addCard (sender: DeckEditTapGestureRecognizer) {
        
        if let index = sender.index {
            if let actualQuantity = sender.actualQuantity {
                switch actualQuantity {
                case 0:
                    let deckCard = DeckCard(card: listOfCards[index], quantity: 1)
                    deck?.main.deckCards.append(deckCard)
                case 4: break
                default:
                    let deckCardIndex = deck?.main.deckCards.firstIndex { $0.card == listOfCards[index] }
                    if let deckCardIndex = deckCardIndex {
                        deck?.main.deckCards[deckCardIndex].quantity = actualQuantity + 1
                    }
                }
                
            }
            
        }
    }
    
    @objc func subtractCard (sender: DeckEditTapGestureRecognizer) {
        print(sender.index ?? "aff")
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        self.selectedCard = cell.card
        performSegue(withIdentifier: "CardViewSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is CardViewController {
            let vc = segue.destination as? CardViewController
            vc?.card = selectedCard
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView: UICollectionReusableView =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionViewHeader", for: indexPath)
            
            return headerView
        }
        
        return UICollectionReusableView()
        
    }
}

extension GatheringViewController: UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !(searchBar.text?.isEmpty)! {
            //reload your data source if necessary
            self.collectionView?.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timerCount += 1
        let actualTimerCount = timerCount
        if searchText.isEmpty {
            _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
                if self.timerCount == actualTimerCount {
                    self.makeRequest()
                    self.listOfCards = []
                }
            }
        } else {
            _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
                if self.timerCount == actualTimerCount {
                    self.makeRequest(name: searchText)
                    self.listOfCards = []
                    
                }
            }
        }
    }
}

class DeckEditTapGestureRecognizer: UITapGestureRecognizer {
    var index: Int?
    var actualQuantity: Int?
}
