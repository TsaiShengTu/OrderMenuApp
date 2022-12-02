//
//  HeartTableViewCell.swift
//  LayaAppVerson1
//
//  Created by 蔡勝宇 on 2022/11/3.
//

import UIKit

class HeartTableViewCell: UITableViewCell {

    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var heartAddressLabel: UILabel!
    @IBOutlet weak var heartImage: UIImageView!
    @IBOutlet weak var heartNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
