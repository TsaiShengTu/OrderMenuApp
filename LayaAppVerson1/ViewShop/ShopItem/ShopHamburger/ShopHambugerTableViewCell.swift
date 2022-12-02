//
//  ShopHambugerTableViewCell.swift
//  LayaAppVerson1
//
//  Created by Sheng-Yu on 2022/10/28.
//

import UIKit

class ShopHambugerTableViewCell: UITableViewCell {
    
    static let reuseIdentifeir = "\(ShopHambugerTableViewCell.self)"
    
    
    @IBOutlet weak var itemCustomization: UIButton!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemAdd: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
