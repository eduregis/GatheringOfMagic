//
//  DeckListScreenViewController.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 08/10/22.
//

import UIKit

class DeckListScreenViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var deckListCollectionView: UICollectionView!
    
    // MARK: - Properties
    var presenter: DeckListScreenPresenter!
    
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
        self.title = DeckListScreenTexts.title.localized()
        configureUI()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.willAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.didAppear()
        loadCards()
    }
    
    // MARK: - Methods
    private func configureUI() {
        prepareCollection()
    }
    
    private func prepareCollection() {
        self.deckListCollectionView.delegate = self
        self.deckListCollectionView.dataSource = self
        DeckListCollectionViewCell.registerNib(for: deckListCollectionView)
        self.deckListCollectionView.contentMode = .center
        self.deckListCollectionView.showsHorizontalScrollIndicator = false
    }
    
    func loadCards() {
        presenter.loadDecks(completion: {
            self.reloadData()
        })
    }
    
    func reloadData() {
        deckListCollectionView.reloadData()
    }

    // MARK: - Actions
    func navigateToDeckDetail(deck: CD_Deck, completion: (() -> Void)?) {
        self.presenter.router.navigateToDeckDetail(deck: deck, completion: completion)
    }
}

// MARK: - SplashScreenPresenterDelegate
extension DeckListScreenViewController: DeckListScreenPresenterDelegate {
    func didLoadRemoteConfig() {
    }
}

extension DeckListScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.decks?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = DeckListCollectionViewCell.dequeueCell(from: collectionView, for: indexPath)
        cell.fill(deck: presenter.decks?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let deck = presenter.decks?[indexPath.row] else { return }
        navigateToDeckDetail(deck: deck, completion: self.reloadData)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  25
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: 187)
    }
}

