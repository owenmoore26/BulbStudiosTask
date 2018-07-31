//
//  ViewController.swift
//  Owen Moore - Bulb Studios
//
//  Created by Ashley Moore on 31/07/2018.
//  Copyright © 2018 Owen Moore. All rights reserved.
//

import UIKit
import Disk

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // References to the storyboard elements
    @IBOutlet weak var shoppingItemsTableView: UITableView!
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var itemToAdd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Lets the tableView manage itself and the customView to be set to hidden on load of the ViewController.
        
        shoppingItemsTableView.delegate = self
        shoppingItemsTableView.dataSource = self
        
        customView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        // Retrieves the array of items to the device memory.
        let savedItems = try! Disk.retrieve("items", from: .caches, as: Array<ShoppingItems>.self)
        items = savedItems
        
        // Counts items array and returns the same number of rows in the tableView.
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Allows my custom cell to be reused multiple times.
        let cell = shoppingItemsTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ShoppingItemsTableViewCell
        
        // Sets the label inside my custom cell to be equal to the current index of the items arrays data.
        cell.itemLabel.text = items[indexPath.row].item
        
        return cell
    }
    
    // Checks to see if the cell has been selected, if the cell has been selected and it does not already have a checkmark then mark it else, remove the checkmark.
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        shoppingItemsTableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
            } else {
                cell.accessoryType = .checkmark
            }
        }
    }
    
    // Allows the cells in the table view to be edited / changed.
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Checks to see if the editing of the cell is of type "delete", if it is I remove the corresponding item to the cell from the items array and delete the row with a fade animation. The array is then saved in user defaults as the latest version.
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            items.remove(at: indexPath.row)
            
            // Saves the array of items to the device memory.
            try! Disk.save(items, to: .caches, as: "items")
            
            shoppingItemsTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // When the add item button is touched the code below is performed to show the view if it isn't already being shown.
    
    @IBAction func addItemTouched(_ sender: Any) {
        
        if customView.isHidden == true {
            customView.isHidden = false
        } else {
            customView.isHidden = false
        }
    }
    
    // Hides the view containing the textfield and buttons.
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        customView.isHidden = true
    }
    
    // When the add button is pressed, the text field is checked to ensure it has text else, an alert will be shown.
    
    @IBAction func addItemToShoppingData(_ sender: Any) {
        if itemToAdd.text == "" {
            
            // Setup an alert to show the user they item field is empty.
            let alert = UIAlertController(title: "Please enter an item", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            // End the editing within the view and hide the view.
            customView.endEditing(true)
            customView.isHidden = true
            
            // Add the new item to the array and set the textfields text to blank for next use.
            let saveItem = ShoppingItems(item: itemToAdd.text!)
            items.append(saveItem)
            
            // Saves the array of items to the device memory.
            try! Disk.save(items, to: .caches, as: "items")
            
            itemToAdd.text = ""
            shoppingItemsTableView.reloadData()
        }
    }
}

