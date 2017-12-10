//
//  Item.swift
//  601wardrobe
//
//  Created by 文淦泉 on 2017/10/25.
//  Copyright © 2017年 Tommy Zheng. All rights reserved.
//
import Foundation
import UIKit
import os.log

class Item: NSObject, NSCoding {
    
    
    //MARK: Properties
    var name: String
    var photo: UIImage?
    var detail: String
    var pref: Double = 5   //preference, default value is 5
    var type: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("items")
    
    //MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let detail = "detail"
        static let pref = "pref"
        static let type = "type"
    }
    
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
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(detail, forKey: PropertyKey.detail)
        aCoder.encode(pref, forKey: PropertyKey.pref)
        aCoder.encode(type, forKey: PropertyKey.type)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let detail = aDecoder.decodeObject(forKey: PropertyKey.detail) as? String
        
        let pref = aDecoder.decodeFloat(forKey: PropertyKey.pref)
        
        let type = aDecoder.decodeObject(forKey: PropertyKey.type) as? String
        
        
        
        // Must call designated initializer.
        self.init(name: name, photo: photo, detail: detail!, pref: Double(pref), type: type!)
        
    }
    
}
