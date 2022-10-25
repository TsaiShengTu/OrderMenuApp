//
//  ShopItemMoreTableViewCell.swift
//  LayaAppVerson1
//
//  Created by 蔡勝宇 on 2022/10/15.
//

import UIKit

class ShopItemMoreTableViewCell: UITableViewCell {

    
    @IBOutlet weak var buttonSum: UIButton!
    var number:Int = 0
    @IBOutlet weak var buttonNumber: UILabel!
    @IBOutlet weak var buttonMinus: UIButton!
    @IBOutlet weak var buttonPlus: UIButton!
    
    override func awakeFromNib() {
        buttonNumber.text = "1"
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func Plus(_ sender: Any) {
        number += 1
        buttonNumber.text = "\(number)"
    }
    
    @IBAction func Minus(_ sender: Any) {
        number  = -1
        buttonNumber.text = "\(number)"
        if buttonNumber.text == "1"{
            buttonMinus.isEnabled
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
