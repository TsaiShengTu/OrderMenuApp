//
//  DataShop.swift
//  LayaAppVerson1
//
//  Created by 蔡勝宇 on 2022/10/12.
//

import Foundation
import UIKit


//店家商品資料

struct  DataShopSell: Codable{
    let records:[Recordl]
}
struct Recordl: Codable{
    let id:String
    let createdTime:String
    let fields:Fieldsl
    
}
struct Fieldsl: Codable {
    let name:String
    let price:String
    let select:String
    let sale:String
    let image:[ShopImage2]
}
struct ShopImage2:Codable{
   let url:URL
}
