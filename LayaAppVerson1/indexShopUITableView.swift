//
//  indexShopUITableView.swift
//  LayaAppVerson1
//
//  Created by 蔡勝宇 on 2022/10/12.
//

import UIKit
import Kingfisher

class indexShopUITableView: UITableView,UITableViewDelegate,UITableViewDataSource {
      
     var list = [DataShopitem]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "indexShopTableViewCell", for: indexPath) as! indexShopTableViewCell
        let shopList = list[indexPath.row]
        cell.shopNameLable.text = shopList.records[0].fields.shopName
        cell.shopAddressLable.text = shopList.records[0].fields.shopAddress
        cell.shopImage.kf.setImage(with: shopList.records[0].fields.shopImage[0].url)
        
        return cell
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
