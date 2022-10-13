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
    var isAnimating: Bool = false
    
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
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.willAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.didAppear()
        loadDecks()
    }
    
    // MARK: - Methods
    private func configureUI() {
        self.blurBackground()
        if let isComingFromTabBar = presenter.isComingFromTabBar {
            if (isComingFromTabBar) {
                self.title = DeckListScreenTexts.title.localized()
            } else {
                self.title = AddToDeckScreenTexts.title.localized()
            }
        }
        setupLongGestureRecognizerOnCollection()
        prepareCollection()
    }
    
    private func prepareCollection() {
        self.deckListCollectionView.delegate = self
        self.deckListCollectionView.dataSource = self
        DeckListCollectionViewCell.registerNib(for: deckListCollectionView)
        self.deckListCollectionView.contentMode = .center
        self.deckListCollectionView.showsHorizontalScrollIndicator = false
        self.deckListCollectionView.backgroundColor = UIColor.clear
    }
    
    func loadDecks() {
        presenter.loadDecks(completion: {
            self.reloadData()
        })
    }
    
    func reloadData() {
        deckListCollectionView.reloadData()
    }

    // MARK: - Actions
    func navigateToDeckDetail(deck: CD_Deck, completion: (() -> Void)?) {
        
        self.presenter.navigateToDeckDetail(deck: deck, completion: completion)
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
        if let isComingFromTabBar = presenter.isComingFromTabBar {
            guard let deck = presenter.decks?[indexPath.row] else { return }
            if (isComingFromTabBar) {
                navigateToDeckDetail(deck: deck, completion: self.reloadData)
            } else {
                let result = presenter.addToDeck(deck: deck)
                if (result.0 == false) {
                    SnackBarHelper.shared.showErrorMessage(message: result.1)
                } else {
                    SnackBarHelper.shared.showSuccessMessage(message: AddToDeckScreenTexts.cardAddedSuccess.localized())
                    loadDecks()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  25
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: 187)
    }
}

// MARK: - Long Press Gesture
extension DeckListScreenViewController: UIGestureRecognizerDelegate {
    
    private func setupLongGestureRecognizerOnCollection() {
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        self.deckListCollectionView.addGestureRecognizer(lpgr)
    }
    
    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        guard gestureReconizer.state != .began else { return }
        let point = gestureReconizer.location(in: self.deckListCollectionView)
        guard let indexPath = self.deckListCollectionView.indexPathForItem(at: point) else { return }
        if let isComingFromTabBar = presenter.isComingFromTabBar, isComingFromTabBar, !isAnimating {
            
            isAnimating = true
            
            UIView.animate(withDuration: 0.3, animations: {
                if let cell = self.deckListCollectionView.cellForItem(at: indexPath) as? DeckListCollectionViewCell {
                    cell.transform = CGAffineTransform(scaleX: 19/20, y: 19/20)
                }
            }) { (completed) in
                
                guard let deck = self.presenter.decks?[indexPath.row] else { return }
                if (isComingFromTabBar) {
                    self.presenter.delegate?.showMessage("\(DeckListScreenTexts.wantToDeleteDeck.localized()) \(deck.name ?? "")?", okAction: {
                        self.presenter.deleteDeck(deck: deck)
                        self.isAnimating = false
                        self.reloadData()
                    }, cancelAction: {
                        self.isAnimating = false
                        self.reloadData()
                    })
                }
                
                UIView.animate(withDuration: 0.3, animations: {
                   if let cell = self.deckListCollectionView.cellForItem(at: indexPath) as? DeckListCollectionViewCell {
                       cell.transform = .identity
                   }
               })
            }
        }
    }
}

