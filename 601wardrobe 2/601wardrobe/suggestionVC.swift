//
//  suggestionVC.swift
//  601wardrobe
//
//  Created by Tommy Zheng on 12/4/17.
//  Copyright © 2017 Tommy Zheng. All rights reserved.
//

import Foundation
import UIKit
import os.log

class suggestionVC: UIViewController {
    
    var wardrobe = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        assignArray()
        //getTempF()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    func getTempF() {
//        let otherVC = SignOutCode()
//        let tempF = otherVC.temp2
//        print(tempF)
//    }
    
    func assignArray() {
        wardrobe = loadItems()!
        if wardrobe.isEmpty {
            print("Empty!")
        } else {
            print(wardrobe[0].type)
        }
    }
    
    
    // Fetech wardrobe items from Database folder
    private func loadItems() -> [Item]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Item.ArchiveURL.path) as? [Item]
    }
    
}
