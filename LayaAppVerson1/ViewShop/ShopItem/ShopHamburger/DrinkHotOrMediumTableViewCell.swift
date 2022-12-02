//
//  DrinkHotOrMediumTableViewCell.swift
//  LayaAppVerson1
//
//  Created by Sheng-Yu on 2022/11/8.
//

import UIKit

class DrinkHotOrMediumTableViewCell: UITableViewCell {

    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
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
