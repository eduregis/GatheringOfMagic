//
//  CardDetailScreenViewController.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 05/10/22.
//

import UIKit
import CoreData

class CardDetailScreenViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var createDeckButton: UIButton!
    @IBOutlet weak var addToDeckButton: UIButton!
    @IBOutlet weak var stackOfButtons: UIStackView!
    
    // MARK: - Properties
    var presenter: CardDetailScreenPresenter!
    
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
//        self.blurBackground()
        presenter.loadCard(completion: {
            self.actualizeUI()
        })
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.willAppear()
        stackOfButtons.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.didAppear()
        
        guard let isFavorited = presenter.isFavorited else { return }
        if (isFavorited) {
            setUnfavoriteButton()
        } else {
            setFavoriteButton()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter.completionHandler!()
    }
    
    // MARK: - Methods
    func actualizeUI() {
        cardImage.sd_setImage(with: URL(string: presenter.currentCard?.imageUrl?.protocolAPS() ?? ""), placeholderImage: UIImage(named: "backCard.png"))
        cardImage.layer.cornerRadius = 25
        setCreateDeckButton()
        setAddToButton()
        stackOfButtons.isHidden = false
    }
    
    func blurBackground() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.backgroundColor = UIColor.clear
        self.view.addSubview(blurEffectView)
        self.view.sendSubviewToBack(blurEffectView)
    }
    
    func setFavoriteButton() {
        if let attrFont = UIFont(name: "Helvetica", size: 12) {
            let title = CardDetailScreenTexts.favorite.localized()
            let attrTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: attrFont])
            favoriteButton.setAttributedTitle(attrTitle, for: UIControl.State.normal)
            favoriteButton.contentHorizontalAlignment = .center
            let image = UIImage(systemName: "star")
            favoriteButton.setImage(image, for: .normal)
        }
    }
    
    func setUnfavoriteButton() {
        if let attrFont = UIFont(name: "Helvetica", size: 12) {
            let title = CardDetailScreenTexts.unfavorite.localized()
            let attrTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: attrFont])
            favoriteButton.setAttributedTitle(attrTitle, for: UIControl.State.normal)
            favoriteButton.contentHorizontalAlignment = .center
            let image = UIImage(systemName: "star.fill")
            favoriteButton.setImage(image, for: .normal)
        }
    }
    
    func setCreateDeckButton() {
        if let attrFont = UIFont(name: "Helvetica", size: 12) {
            let title = CardDetailScreenTexts.createNewDeck.localized()
            let attrTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: attrFont])
            createDeckButton.setAttributedTitle(attrTitle, for: UIControl.State.normal)
            createDeckButton.contentHorizontalAlignment = .center
        }
    }
    
    func setAddToButton() {
        if let attrFont = UIFont(name: "Helvetica", size: 12) {
            let title = CardDetailScreenTexts.addToDeck.localized()
            let attrTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: attrFont])
            addToDeckButton.setAttributedTitle(attrTitle, for: UIControl.State.normal)
            addToDeckButton.contentHorizontalAlignment = .center
        }
    }


    // MARK: - Actions
    
    @IBAction func favoriteAction(_ sender: Any) {
        guard let isFavorited = presenter.isFavorited else { return }
        if (isFavorited) {
            presenter.unfavoriteCard()
            setFavoriteButton()
        } else {
            presenter.favoriteCard()
            setUnfavoriteButton()
        }
    }
    
    @IBAction func createDeckAction(_ sender: Any) {
        presenter.createDeck()
    }
    
    @IBAction func addToDeckAction(_ sender: Any) {
        presenter.navigateToAddToDeckScreen()
    }
    
}

// MARK: - CardDetailScreenPresenterDelegate
extension CardDetailScreenViewController: CardDetailScreenPresenterDelegate {
    func didLoadRemoteConfig() {
    }
}
