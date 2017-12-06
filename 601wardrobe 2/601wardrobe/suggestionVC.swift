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


class suggestionVC: UIViewController, Delegate {

    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var suggestedCloths: UIImageView!
    var wardrobe = [Item]()
    //var temp = Double()
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
    @IBAction func getTheTemp(_ sender: Any) {
        performSegue(withIdentifier: "SuggestToSign", sender: nil)    
    
    }
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if let destination = segue.destination as? SignOutCode{
            destination.delegate = self
        }
    }

    func getTemp(with temp_to_send: Double) {
        tempLabel.text = String(temp_to_send)
        print("In get Temp")
        print(temp_to_send)
        get_clothes(with: temp_to_send)
    }
 
    func assignArray() {
        wardrobe = loadItems()!
        if wardrobe.isEmpty {
            print("Empty!")
        } else {
            //print(wardrobe[0].type)
        }
    }
    func get_clothes(with tempsent: Double){
       if tempsent > 10{
        for i in 0...10{
            if wardrobe[i].type == "dress"{
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
            if wardrobe[i].type == "t-shirt"{
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
    


