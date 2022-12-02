//
//  ShopSellListTableViewCell.swift
//  LayaAppVerson1
//
//  Created by 蔡勝宇 on 2022/10/13.
//

import UIKit

class ShopSellListTableViewCell: UITableViewCell {

    @IBOutlet weak var shopSellPrice: UILabel!
    @IBOutlet weak var shopSellName: UILabel!
    @IBOutlet weak var shopSellImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
