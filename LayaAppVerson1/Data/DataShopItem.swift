//
//  DataShopItem.swift
//  LayaAppVerson1
//
//  Created by 蔡勝宇 on 2022/10/14.
//

import Foundation
import UIKit

struct DataShopItem:Codable{
    let records:[Record2]
}
struct Record2:Codable{
    let id:String
    let createdTime:String
    let fields:Fields2
}
struct Fields2:Codable{
    let priceItem:String?
    let nameItem:String
}



//這邊是 漢堡選單的資料
struct ShopItemFood{
    let name:String
    let price:Int
    var isadd = false
}

enum ShopItemSection:Int{
    case set
    case topping
}


//這邊是套餐選單的資料
struct ShopItemSet{
    let name:String
    let price:Int
    var isadd = false
}

enum ShopItemSetSection:Int{
    case meal
    case drink
    case toppingGrade
}

