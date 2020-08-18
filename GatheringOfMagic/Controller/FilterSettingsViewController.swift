//
//  FilterSettingsViewController.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 18/08/20.
//  Copyright © 2020 Eduardo Oliveira. All rights reserved.
//

import UIKit

class FilterSettingsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        filterByPicker.delegate = self
        filterByPicker.dataSource = self
    }
    
    let filterByPickerData = ["Name","Type","Text"]
    
    @IBOutlet weak var filterByPicker: UIPickerView!
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
        print(UserDefaults.standard.string(forKey: "filter") ?? "")
    }
}
