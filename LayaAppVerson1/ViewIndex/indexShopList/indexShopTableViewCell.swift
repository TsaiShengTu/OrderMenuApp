//
//  indexShopTableViewCell.swift
//  LayaAppVerson1
//
//  Created by 蔡勝宇 on 2022/10/12.
//

import UIKit

class indexShopTableViewCell: UITableViewCell {

    @IBOutlet weak var shopAddressLable: UILabel!
    @IBOutlet weak var shopNameLable: UILabel!
    @IBOutlet weak var shopImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
