//
//  Item.swift
//  601wardrobe
//
//  Created by 文淦泉 on 2017/10/25.
//  Copyright © 2017年 Tommy Zheng. All rights reserved.
//

import Foundation
import UIKit

class Item {
    
    //MARK: Properties
    var name: String
    var photo: UIImage?
    var detail: String
    var pref: Double = 5   //preference, default value is 5
    var type: String
    
    //MARK: Initialization
    init? (name: String, photo: UIImage?, detail: String, pref: Double, type: String){
        
        // Initialization should fail if there is no name or if the preference is out of range.
        guard !name.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (pref >= 1) && (pref <= 9) else {
            return nil
        }
        
        //Initialize stored properties
        self.name = name
        self.photo = photo
        self.detail = detail
        self.pref = pref
        self.type = type
    }
}
