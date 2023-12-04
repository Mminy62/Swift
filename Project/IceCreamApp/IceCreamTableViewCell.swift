//
//  IceCreamTableViewCell.swift
//  IceCreamApp
//
//  Created by 이민영 on 2023/11/23.
//

import UIKit

class IceCreamTableViewCell: UITableViewCell {

    @IBOutlet var itemImage: UIImageView!
    @IBOutlet var itemName: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
