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
    
    var selectedCard: Card?
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
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
        triggerIndicator(status: false)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
        }
        // caso vá usar dark mode
        //overrideUserInterfaceStyle = .dark
    }
    
    private func setupNavigationbarItems () {
        let titleImageView = UIImageView(image: UIImage(imageLiteralResourceName: "GatheringOfMagic"))
        titleImageView.frame = CGRect(x: 0, y: 0, width: 92, height: 30)
        titleImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = titleImageView
    }
    
    func triggerIndicator (status: Bool) {
        if status {
            indicator.isHidden = false
            indicator.startAnimating()
        } else {
            indicator.isHidden = true
            indicator.stopAnimating()
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
        cell.configure(with: listOfCards[indexPath.row])
        return cell
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
