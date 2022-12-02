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


//套餐選單的資料
struct ShopItemSet{
    //商品名稱
    let name:String
    //商品價錢
    let price:Int
    //商品有無點選
    var isadd = false
    //商品類別
    let setNumber:Int
    //商品客製化選項
    var choices: [String]
}

//section的分類
enum ShopItemSetSectionInt:Int{
    case meal
    case drink
    case toppingGrade
}

//這邊是飲料選單的資料

struct ShopDrinkItem{
    let name:String
    let price:Int?
    var isadd = false
}

enum ShopDrinkItemSection:Int{
    case hotOrcold
    case mediumOrLagre
}





enum ShopItemSetSection:Int{
    case meal
    case drink
    case toppingGrade
}


struct ShopItemSetPeter{
    let category:ShopItemSetSectionPeter
    var name:[String]
    var price:[Int]
    var isadd = false
}

enum ShopItemSetSectionPeter:String{
    case meal
    case drink
    case toppingGrade
}





extension ShopItemSetPeter{
    static var data:[Self]{
        [ShopItemSetPeter(category: .meal, name: [], price: []),
         ShopItemSetPeter(category: .drink, name: ["紅茶","玄米煎茶","奶茶", "豆漿","蘋果茶","薏仁漿","鮮檸冬瓜", "可可","青檸紅茶","柳橙汁","柚香蜂蜜檸檬","紅茶拿鐵","奶酪奶茶","美式咖啡","拿鐵咖啡","鴛鴦咖啡"], price: [0,0,5,5,5,10,10,15,15,15,15,20,29,15,25,25]),
         ShopItemSetPeter(category: .toppingGrade, name: ["請點選加購品項","三角薯餅(3塊)(原價25元)","麥克雞塊(4塊)(原價35元)","美式雞柳條(原價45元)"], price: [0,20,30,40])
       ]
    }
}
