//
//  HamburgerDrinkIceTableViewCell.swift
//  LayaAppVerson1
//
//  Created by 蔡勝宇 on 2022/11/10.
//

import UIKit

class HamburgerDrinkIceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var itemAddButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
