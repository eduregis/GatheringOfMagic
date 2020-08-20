//
//  FilterSettingsViewController.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 18/08/20.
//  Copyright © 2020 Eduardo Oliveira. All rights reserved.
//

import UIKit

class FilterSettingsViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        let actualFilterValue = UserDefaults.standard.string(forKey: "filter")
        for index in 0..<filterByPickerData.count {
            if filterByPickerData[index].lowercased() == actualFilterValue {
                filterByPicker.selectRow(index, inComponent: 0, animated: true)
            }
        }
        whiteSwitch.isOn = UserDefaults.standard.bool(forKey: "whiteSwitch")
        blueSwitch.isOn = UserDefaults.standard.bool(forKey: "blueSwitch")
        blackSwitch.isOn = UserDefaults.standard.bool(forKey: "blackSwitch")
        redSwitch.isOn = UserDefaults.standard.bool(forKey: "redSwitch")
        greenSwitch.isOn = UserDefaults.standard.bool(forKey: "greenSwitch")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        filterByPicker.delegate = self
        filterByPicker.dataSource = self
    }
    
    let filterByPickerData = ["Name", "Type", "Text"]
    
    @IBOutlet weak var filterByPicker: UIPickerView!
    
    @IBOutlet weak var whiteSwitch: UISwitch!
    @IBOutlet weak var blueSwitch: UISwitch!
    @IBOutlet weak var blackSwitch: UISwitch!
    @IBOutlet weak var redSwitch: UISwitch!
    @IBOutlet weak var greenSwitch: UISwitch!
    
    @IBAction func whiteSwitch(_ sender: Any) {
        UserDefaults.standard.set(whiteSwitch.isOn, forKey: "whiteSwitch")
    }
    
    @IBAction func blueSwitch(_ sender: Any) {
        UserDefaults.standard.set(blueSwitch.isOn, forKey: "blueSwitch")
    }
    
    @IBAction func blackSwitch(_ sender: Any) {
        UserDefaults.standard.set(blackSwitch.isOn, forKey: "blackSwitch")
    }
    
    @IBAction func redSwitch(_ sender: Any) {
        UserDefaults.standard.set(redSwitch.isOn, forKey: "redSwitch")
    }
    
    @IBAction func greenSwitch(_ sender: Any) {
        UserDefaults.standard.set(greenSwitch.isOn, forKey: "greenSwitch")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        default: return 5
        }
    }
    
}

extension FilterSettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filterByPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return filterByPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UserDefaults.standard.set(filterByPickerData[row].lowercased(), forKey: "filter")
    }
}
