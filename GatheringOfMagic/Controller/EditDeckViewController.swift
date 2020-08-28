//
//  EditDeckViewController.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 28/08/20.
//  Copyright © 2020 Eduardo Oliveira. All rights reserved.
//

import UIKit

class EditDeckViewController: UITableViewController {

    var deck: Deck? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var listOfDecks = [Deck]()
    
    let alert = UIAlertController(title: "Alert", message: "This deck will be deleted forever, are you proceed?", preferredStyle: .alert)
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBAction func deleteDeck(_ sender: Any) {
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit \(deck?.name ?? "")"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(changesDone))
        tableView.tableFooterView = UIView()
        nameField.text = deck?.name
        addActions()
    }
    
    func addActions() {
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Confirm", comment: "Default action"), style: .destructive, handler: { _ in
            let index = self.listOfDecks.firstIndex {$0.index == self.deck?.index }
            let deletedDeck = self.listOfDecks[index!]
            Database.shared.deleteDeck(from: .deckList, at: deletedDeck)
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
        }))
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

    @objc func changesDone () {
        deck?.name = nameField.text
        let oldDeckIndex = listOfDecks.firstIndex { $0.index == deck?.index }
               if let oldDeckIndex = oldDeckIndex {
                   if let deck = deck {
                       listOfDecks[oldDeckIndex] = deck
                       Database.shared.saveData(from: listOfDecks, to: .deckList)
                   }
               }
           navigationController?.popViewController(animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

}
