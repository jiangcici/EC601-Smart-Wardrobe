//
//  InvtViewCell.swift
//  601wardrobe
//
//  Created by Tommy Zheng on 12/9/17.
//  Copyright © 2017 Tommy Zheng. All rights reserved.
//

import UIKit

class InvtViewCell: UITableViewCell {
    
    @IBOutlet weak var Photo: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var DetailLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
