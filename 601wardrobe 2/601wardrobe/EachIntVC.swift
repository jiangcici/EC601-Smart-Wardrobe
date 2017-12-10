//
//  EachIntVC.swift
//  601wardrobe
//
//  Created by Tommy Zheng on 12/9/17.
//  Copyright © 2017 Tommy Zheng. All rights reserved.
//

import Foundation
import UIKit
import os.log

class EachIntVC: UITableViewController {

    var wardrobe1 = [Item]()
    var temp = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Inventory")
        if let savedItems = loadItems() {
            wardrobe1 += savedItems
        }
        tempcount()
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
    
    func tempcount() {
        if categories[myIndex] == "Dress" {
            for i in wardrobe1 {
                if i.type == "dress" {
                    temp.append(i)
                }
            }
        } else if categories[myIndex] == "Heel" {
            for i in wardrobe1 {
                if i.type == "heel" {
                    temp.append(i)
                }
            }
        } else if categories[myIndex] == "Shoe" {
            for i in wardrobe1 {
                if i.type == "shoe" {
                    temp.append(i)
                }
            }
        } else if categories[myIndex] == "Tee" {
            for i in wardrobe1 {
                if i.type == "t-shirt" {
                    temp.append(i)
                }
            }
        } else if categories[myIndex] == "Trouser" {
            for i in wardrobe1 {
                if i.type == "trouser" {
                    temp.append(i)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return temp.count
    }

    private func loadItems() -> [Item]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Item.ArchiveURL.path) as? [Item]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "InvtViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? InvtViewCell  else {
            fatalError("The dequeued cell is not an instance of ItemTableViewCell.")
        }
        
        // Fetches the appropriate item for the data source layout.
        if temp.isEmpty {
            
            return cell
            
        } else {
            
            let item = temp[indexPath.row]
            
            cell.NameLabel.text = item.name
            cell.Photo.image = item.photo
            cell.DetailLabel.text = item.detail
        
            return cell
        }
    }


}
