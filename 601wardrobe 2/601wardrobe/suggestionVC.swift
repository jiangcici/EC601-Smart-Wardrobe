//
//  suggestionVC.swift
//  601wardrobe
//  Modified by Ashley Antony Gomez on 12/6/17.
//  Created by Tommy Zheng on 12/4/17.
//  Copyright © 2017 Tommy Zheng. All rights reserved.
//

import Foundation
import UIKit
import os.log


class suggestionVC: UIViewController {
    
    var temp_sent: Double
        = 0.0

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var emptylabel: UILabel!
    @IBOutlet weak var suggestedCloths: UIImageView!
    var wardrobe = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        assignArray()
//        tempLabel.text = String(temp_sent)
//        getTemp(with: temp_sent)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   //  To get temperature
    func getTemp(with temp_sent: Double) {
        tempLabel.text = String(format: "%.1f", temp_sent)
        print("In get Temp")
        print(temp_sent)
        get_clothes(with: temp_sent)
    }
 
    func assignArray() {
        wardrobe = (loadItems())!
        if wardrobe.isEmpty {
            emptylabel.text = "Please add more apparels to wardrobe"
            tempLabel.text = ""
            print("Empty!")
        } else {
            tempLabel.text = String(temp_sent)
            getTemp(with: temp_sent)
            emptylabel.text = ""
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func get_clothes(with tempsent: Double){
       if tempsent > 10{
        for i in 0...10{
            if wardrobe[i].type == "dress" || wardrobe[i].type == "shoe" {
                print(">10")
                print(wardrobe[i].type)
                suggestedCloths.image = wardrobe[i].photo
                break
            }
            else{
                continue
            }
        }
       }
       else {
        for i in 0...10{
            if wardrobe[i].type == "t-shirt" || wardrobe[i].type == "shoe" {
                print("<10")
                print(wardrobe[i].type)
                suggestedCloths.image = wardrobe[i].photo
                break
            }
            else{
                continue
            }
        }
        }
    }
            
}

    // Fetch wardrobe items from Database folder
    private func loadItems() -> [Item]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Item.ArchiveURL.path) as? [Item]
    }
    


