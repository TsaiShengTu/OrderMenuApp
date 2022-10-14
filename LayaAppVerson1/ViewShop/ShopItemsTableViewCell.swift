//
//  ShopItemsTableViewCell.swift
//  LayaAppVerson1
//
//  Created by 蔡勝宇 on 2022/10/14.
//

import UIKit

class ShopItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var itemButton: UIButton!
    @IBOutlet weak var itemsPrice: UILabel!
    @IBOutlet weak var itemsName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func selectedButton(_ sender: Any) {
        
        itemButton.isSelected.toggle()

        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
