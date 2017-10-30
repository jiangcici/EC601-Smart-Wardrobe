//
//  ItemTableViewController.swift
//  601wardrobe
//
//  Created by 文淦泉 on 2017/10/28.
//  Copyright © 2017年 Tommy Zheng. All rights reserved.
//

import UIKit
import os.log

class ItemTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var items = [Item]()

    @IBAction func Edit(_ sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        
        if tableView.isEditing {
            self.editButtonItem.title = "Done"
        } else {
            self.editButtonItem.title = "Edit"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        //navigationItem.rightBarButtonItem = editButtonItem

        loadSampleItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ItemTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ItemTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let item = items[indexPath.row]
        
        cell.nameLabel.text = item.name
        cell.photoImageView.image = item.photo
        cell.detailLabel.text = item.detail
        
        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new item.", log: OSLog.default, type: .debug)
            
        case "showDetail":
            guard let itemDetailViewController = segue.destination as? detailPage else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedItemCell = sender as? ItemTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedItemCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedItem = items[indexPath.row]
            itemDetailViewController.item = selectedItem
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
 
    
    //Actions
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? detailPage, let item = sourceViewController.item {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing item.
                items[selectedIndexPath.row] = item
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new item.
                let newIndexPath = IndexPath(row: items.count, section: 0)
                
                items.append(item)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    
    private func loadSampleItems(){
        
        let photo1 = UIImage(named: "Top")
        let photo2 = UIImage(named: "Pant")
        
        guard let item1 = Item(name: "Sweater", photo: photo1, detail: "Vans grey sweater", pref: 5, type:"top") else {
            fatalError("Unable to instantiate item1")
        }
        
        guard let item2 = Item(name: "Straight Jeans", photo: photo2, detail: "light blue", pref: 5, type:"pant") else {
            fatalError("Unable to instantiate item2")
        }
        
        items += [item1, item2]
        
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

}
