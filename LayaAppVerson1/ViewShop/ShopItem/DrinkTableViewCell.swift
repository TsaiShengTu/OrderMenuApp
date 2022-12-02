//
//  DrinkTableViewCell.swift
//  LayaAppVerson1
//
//  Created by 蔡勝宇 on 2022/10/30.
//

import UIKit

class DrinkTableViewCell: UITableViewCell {

    @IBOutlet weak var itemsPrice: UILabel!
    @IBOutlet weak var itemsName: UILabel!
    @IBOutlet weak var itemButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
