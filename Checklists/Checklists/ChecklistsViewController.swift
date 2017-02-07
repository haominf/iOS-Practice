//
//  ViewController.swift
//  Checklists
//
//  Created by FengHaomin on 08/01/2017.
//  Copyright © 2017 HaoMin Feng. All rights reserved.
//

import UIKit

class ChecklistsViewController: UITableViewController {
    
    var items: [ChecklistsItem]
    
    required init?(coder aDecoder: NSCoder) {
        items = [ChecklistsItem]()
        let row0item = ChecklistsItem()
        row0item.text = "Walk the dog"
        row0item.isChecked = false
        items.append(row0item)
        let row1item = ChecklistsItem()
        row1item.text = "Brush my teeth"
        row1item.isChecked = true
        items.append(row1item)
        let row2item = ChecklistsItem()
        row2item.text = "Learn iOS development"
        row2item.isChecked = true
        items.append(row2item)
        let row3item = ChecklistsItem()
        row3item.text = "Soccer practice"
        row3item.isChecked = false
        items.append(row3item)
        let row4item = ChecklistsItem()
        row4item.text = "Eat ice cream"
        row4item.isChecked = true
        items.append(row4item)
        let row5item = ChecklistsItem()
        row5item.text = "毛毛老公是朴宝剑"
        row5item.isChecked = true
        items.append(row5item)
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ChecklistsItem", for: indexPath)
        
        let item = items[indexPath.row]
        
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            item.toggleChecked()
            configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }

    func configureCheckmark(for cell: UITableViewCell,
                            with item: ChecklistsItem) {
        if item.isChecked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    func configureText(for cell: UITableViewCell,
                       with item: ChecklistsItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
    @IBAction func addItems() {
        let newRowIndex = items.count
        
        let item = ChecklistsItem()
        item.text = "new row lol"
        item.isChecked = false
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
}

