//
//  AddToADeckViewController.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 21/08/20.
//  Copyright © 2020 Eduardo Oliveira. All rights reserved.
//

import UIKit

class AddToADeckViewController: UITableViewController {
    
    var deck: Deck?
    var card: Card?
    
    var listOfDecks = [Deck]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        self.title = "Add \(card?.name ?? "card") to a \(deck?.name ?? "deck")"
        
        guard let imageUrlString = card?.imageUrl else { return }
        
        guard let imageUrl = URL(string: imageUrlString) else { return }
        
        mainCard.load(url: imageUrl)
        countOfMainCopies.text = "\(copiesInDeck("main"))"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchDecks()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    func fetchDecks () {
        listOfDecks = Database.shared.loadData(from: .deckList)
    }
    
    @IBOutlet weak var mainCard: UIImageView!
    @IBOutlet weak var countOfMainCopies: UILabel!
    
    @IBAction func addCopyToMain(_ sender: Any) {
        if copiesInDeck("main") == 0 {
            let deckCard = DeckCard(card: card!, quantity: 1)
            deck?.main.deckCards.append(deckCard)
            
            tableView.reloadData()
        }
        countOfMainCopies.text = "\(copiesInDeck("main"))"
        
    }
    
    func deckCount (_ type: String) -> Int {
        var count: Int = 0
        switch type {
        case "main":
            deck?.main.deckCards.forEach {
                count += $0.quantity
            }
        case "side":
            deck?.sideboard.deckCards.forEach {
                count += $0.quantity
            }
        default: break
        }
        return count
    }
    
    func copiesInDeck (_ type: String) -> Int {
        var count: Int = 0
        switch type {
        case "main":
            deck?.main.deckCards.forEach {
                if $0.card.name == card?.name {
                count += $0.quantity
                }
            }
        case "side":
            deck?.sideboard.deckCards.forEach {
                if $0.card.name == card?.name {
                count += $0.quantity
                }
            }
        default: break
        }
        return count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Add to a Mainboard (\(deckCount("main")) - 60)"
        } else if section == 1 {
            return "Add to a Mainboard (\(deckCount("side")) - 15)"
        }
        return ""
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
