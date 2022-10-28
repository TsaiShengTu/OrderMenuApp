//
//  orderListItem.swift
//  LayaAppVerson1
//
//  Created by 蔡勝宇 on 2022/10/16.
//

import Foundation

//上傳網路的函式


struct OrderListItem:Codable{
    let records:[Record4]
}
struct Record4:Codable{
//    let id:String?
//    let createdTime:String?
    let fields:Fields4
}
struct Fields4:Codable{
    //品項名稱
    let itemName:String
    //品項價錢
    let priceSum:Int
    //加點
    let toppingAndMeals:[String]
    //備註
    let textField:String
    //品項數量
    let itemNumber:Int
    
    
    
}


