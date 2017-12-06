//
//  ItemTableViewCell.swift
//  601wardrobe
//
//  Created by 文淦泉 on 2017/10/28.
//  Copyright © 2017年 Tommy Zheng. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
