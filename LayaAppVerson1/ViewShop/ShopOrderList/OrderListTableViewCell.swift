//
//  OrderListTableViewCell.swift
//  LayaAppVerson1
//
//  Created by Sheng-Yu on 2022/10/19.
//

import UIKit

class OrderListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemTopping: UILabel!
    @IBOutlet weak var itemWriteSomething: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    
    @IBOutlet weak var ItemToppingAllLabel: UILabel!
    @IBOutlet weak var itemNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
