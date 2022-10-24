//
//  FavoriteListScreenViewController.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 08/10/22.
//

import UIKit

class FavoriteListScreenViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var favoriteListCollectionView: UICollectionView!
    @IBOutlet weak var emptyBoxImage: UIImageView!
    @IBOutlet weak var emptyLabel: UILabel!
    
    // MARK: - Properties
    var presenter: FavoriteListScreenPresenter!
    
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
        self.blurBackground()
        self.title = FavoriteListScreenTexts.title.localized()
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
        hideEmptyBox()
        prepareCollection()
    }
    
    private func prepareCollection() {
        self.favoriteListCollectionView.delegate = self
        self.favoriteListCollectionView.dataSource = self
        CardListCollectionViewCell.registerNib(for: favoriteListCollectionView)
        self.favoriteListCollectionView.contentMode = .center
        self.favoriteListCollectionView.showsHorizontalScrollIndicator = false
        self.favoriteListCollectionView.backgroundColor = UIColor.clear
    }
    
    private func showEmptyBox() {
        emptyBoxImage.isHidden = false
        emptyBoxImage.alpha = 0.5
        emptyLabel.text = "Ainda não tem nenhuma carta favoritada! localizar"
        emptyLabel.numberOfLines = 0
        emptyLabel.lineBreakMode = .byTruncatingTail
        emptyLabel.alpha = 0.5
        emptyLabel.isHidden = false
    }
    
    private func hideEmptyBox() {
        emptyBoxImage.isHidden = true
        emptyLabel.isHidden = true
    }
    
    func loadCards() {
        presenter.loadFavoriteCards(completion: {
            self.reloadData()
        })
    }
    
    func reloadData() {
        presenter.updateFavorites()
        favoriteListCollectionView.reloadData()
        if (presenter.isListEmpty()) {
            showEmptyBox()
        } else {
            hideEmptyBox()
        }
    }

    // MARK: - Actions
    func navigateToCardDetail(cardId: String, completion: (() -> Void)?) {
        self.presenter.navigateToCardDetail(cardId: cardId, completion: completion)
    }
}

// MARK: - SplashScreenPresenterDelegate
extension FavoriteListScreenViewController: FavoriteListScreenPresenterDelegate {
    func didLoadRemoteConfig() {
    }
}

extension FavoriteListScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.favoriteCards?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CardListCollectionViewCell.dequeueCell(from: collectionView, for: indexPath)
        cell.fill(
            name: presenter.favoriteCards?[indexPath.row].name,
            imageURL: presenter.favoriteCards?[indexPath.row].imageUrl,
            isFavorited: true
        )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let card = presenter.favoriteCards?[indexPath.row] else { return }
        navigateToCardDetail(cardId: card.id ?? "", completion: self.reloadData)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  25
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/3, height: 187)
    }
}
