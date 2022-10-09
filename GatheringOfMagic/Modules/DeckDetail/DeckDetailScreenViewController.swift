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
    @IBOutlet weak var cardsCollectionVIew: UICollectionView!
    
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
        // Do any additional setup after loading the view, typically from a nib.
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
        prepareCollection()
    }
    
    private func prepareCollection() {
        self.cardsCollectionVIew.delegate = self
        self.cardsCollectionVIew.dataSource = self
        CardListCollectionViewCell.registerNib(for: cardsCollectionVIew)
        self.cardsCollectionVIew.contentMode = .center
        self.cardsCollectionVIew.showsHorizontalScrollIndicator = false
    }
}

// MARK: - CardDetailScreenPresenterDelegate
extension DeckDetailScreenViewController: DeckDetailScreenPresenterDelegate {
    func didLoadRemoteConfig() {
    }
}

extension DeckDetailScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return presenter.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CardListCollectionViewCell.dequeueCell(from: collectionView, for: indexPath)
        cell.fill(
            name: presenter.cards[indexPath.row].name,
            imageURL: presenter.cards[indexPath.row].imageUrl
        )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  25
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/3, height: 187)
    }
}
