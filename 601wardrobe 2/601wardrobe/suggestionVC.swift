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
    @IBOutlet weak var suggestedClothe2: UIImageView!
    @IBOutlet weak var suggestedClothe3: UIImageView!
    var wardrobe = [Item]()
    var dresses = [Item]()
    var heels = [Item]()
    var shoes = [Item]()
    var tees = [Item]()
    var trousers = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        assignArray()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   //  To get temperature
    func getTemp(with temp_sent: Double) {
        tempLabel.text = String(format: "%.1f", temp_sent) + String("  °C")
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

    func get_clothes(with tempsent: Double) {
        if tempsent > 10 {
            suggestedClothe3.image = #imageLiteral(resourceName: "blank_image")
            for i in 0 ..< wardrobe.count{
                if wardrobe[i].type == "dress"{
                    dresses.append(wardrobe[i])
                }
                else if wardrobe[i].type == "heel"{
                    heels.append(wardrobe[i])
                }
            }
            if dresses.isEmpty{
                suggestedCloths.image = #imageLiteral(resourceName: "blank_image")
            }
            else{
                let n = dresses.count
                let rndind = Int(arc4random_uniform(UInt32(n)))
                suggestedCloths.image = dresses[rndind].photo
            }
            if heels.isEmpty{
                suggestedClothe2.image = #imageLiteral(resourceName: "blank_image")
            }
            else{
                let n = heels.count
                let rndind = Int(arc4random_uniform(UInt32(n)))
                suggestedClothe2.image = heels[rndind].photo
            }
            if dresses.isEmpty && heels.isEmpty {
                tempLabel.text = ""
            }

        }
        else{
            for i in 0 ..< wardrobe.count{
                if wardrobe[i].type == "t-shirt"{
                    tees.append(wardrobe[i])
                }
                else if wardrobe[i].type == "shoe"{
                    shoes.append(wardrobe[i])
                }
                else if wardrobe[i].type == "trouser"{
                    trousers.append(wardrobe[i])
                }
            }
            if tees.isEmpty{
                suggestedCloths.image = #imageLiteral(resourceName: "blank_image")
            }
            else{
                let n = tees.count
                let rndind = Int(arc4random_uniform(UInt32(n)))
                suggestedCloths.image = tees[rndind].photo
            }
            if trousers.isEmpty{
                suggestedClothe2.image = #imageLiteral(resourceName: "blank_image")
            }
            else{
                let n = trousers.count
                let rndind = Int(arc4random_uniform(UInt32(n)))
                suggestedClothe2.image = trousers[rndind].photo
            }
            if shoes.isEmpty{
                suggestedClothe3.image = #imageLiteral(resourceName: "blank_image")
            }
            else{
                let n = shoes.count
                let rndind = Int(arc4random_uniform(UInt32(n)))
                suggestedClothe3.image = shoes[rndind].photo
            }
            if tees.isEmpty && shoes.isEmpty && trousers.isEmpty {
                tempLabel.text = ""
            }
        }
    }

    // Fetch wardrobe items from Database folder
    private func loadItems() -> [Item]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Item.ArchiveURL.path) as? [Item]
    }
    
}

