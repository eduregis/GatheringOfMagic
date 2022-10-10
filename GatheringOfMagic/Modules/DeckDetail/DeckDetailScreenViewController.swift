//
//  DeckDetailScreenViewController.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 08/10/22.
//

import UIKit
import CoreData

class DeckDetailScreenViewController: BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var deckName: UILabel!
    @IBOutlet weak var cardsInDeckLabel: UILabel!
    @IBOutlet weak var manaLabel: UILabel!
    @IBOutlet weak var averageCostLabel: UILabel!
    @IBOutlet weak var cardsCollectionView: UICollectionView!
    @IBOutlet weak var cardsCVHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    var presenter: DeckDetailScreenPresenter!
    
    // MARK: - View Lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.didLoad()
        self.actualizeUI()
        self.view.layoutIfNeeded()
    }
    
    override func viewDidLayoutSubviews() {
        self.changeCollectionHeight()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.willAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.didAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter.completionHandler!()
    }
    
    // MARK: - Methods
    func actualizeUI() {
        deckName.text = presenter.currentDeck?.name
        cardsInDeckLabel.text = "\(presenter.currentDeck?.format ?? "") (\(presenter.cards.count))"
        manaLabel.text = DeckDetailScreenTexts.mana.localized()
        averageCostLabel.text = DeckDetailScreenTexts.averageCost.localized()
        prepareCollection()
    }
    
    private func prepareCollection() {
        self.cardsCollectionView.delegate = self
        self.cardsCollectionView.dataSource = self
        CardListCollectionViewCell.registerNib(for: cardsCollectionView)
        self.cardsCollectionView.contentMode = .center
        self.cardsCollectionView.showsHorizontalScrollIndicator = false
        cardsCollectionView?.register(DeckDetailCollectionViewHeader.self, forSupplementaryViewOfKind:
                                        UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
    }
    
    func changeCollectionHeight() {
        self.cardsCVHeightConstraint.constant = self.cardsCollectionView.contentSize.height
    }
}

// MARK: - CardDetailScreenPresenterDelegate
extension DeckDetailScreenViewController: DeckDetailScreenPresenterDelegate {
    func didLoadRemoteConfig() {
    }
}

extension DeckDetailScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return CardTypes.total.rawValue
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let collectionSection = CardTypes(rawValue: section), let cardData = presenter.sortedCards[collectionSection] {
            return cardData.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if let collectionSection = CardTypes(rawValue: section) {
            if (presenter.sortedCards[collectionSection]!.count > 0) {
                return CGSize(width: view.frame.width, height: 20)
            }
        }
        
        return CGSize(width: view.frame.width, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind:
        String, at indexPath: IndexPath) -> UICollectionReusableView {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "headerId",
                for: indexPath) as! DeckDetailCollectionViewHeader
        if let collectionSection = CardTypes(rawValue: indexPath.section) {
            header.typeLabel.text = presenter.titleForHeader(type: collectionSection)
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CardListCollectionViewCell.dequeueCell(from: collectionView, for: indexPath)
        if let collectionSection = CardTypes(rawValue: indexPath.section), let card = presenter.sortedCards[collectionSection]?[indexPath.row] {
            cell.fill(
                name: card.name,
                imageURL: card.imageUrl,
                quantity: Int(card.quantity))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  25
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/4, height: 187)
    }
}
