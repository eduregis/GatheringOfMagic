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
    
    // MARK: - Properties
    var isBlocked = false
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
        self.blurBackground()
        presenter.loadCard(completion: {
            self.actualizeUI()
        })
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.willAppear()
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
    
    // MARK: - Methods
    func actualizeUI() {
        cardImage.sd_setImage(with: URL(string: presenter.currentCard?.imageUrl?.protocolAPS() ?? ""), placeholderImage: UIImage(named: "backCard.png"))
        cardImage.layer.cornerRadius = 20
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
//        favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
//        favoriteButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 12.0)
//        favoriteButton.setTitle("Favoritar", for: .normal)
        
        if let attrFont = UIFont(name: "Helvetica", size: 12) {
            let title = "Favoritar"
            let attrTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: attrFont])
            favoriteButton.setAttributedTitle(attrTitle, for: UIControl.State.normal)
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    func setUnfavoriteButton() {
//        favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
//        favoriteButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 12.0)
//        favoriteButton.setTitle("Desfavoritar", for: .normal)
        
        if let attrFont = UIFont(name: "Helvetica", size: 12) {
            let title = "Desfavoritar"
            let attrTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: attrFont])
            favoriteButton.setAttributedTitle(attrTitle, for: UIControl.State.normal)
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
    }

    // MARK: - Actions
    func navigateToCardList() {
        self.presenter.router.backToList()
    }
    
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
        
    }
    
    @IBAction func addToDeckAction(_ sender: Any) {
    }
    
}

// MARK: - CardDetailScreenPresenterDelegate
extension CardDetailScreenViewController: CardDetailScreenPresenterDelegate {
    func didLoadRemoteConfig() {
    }
}
