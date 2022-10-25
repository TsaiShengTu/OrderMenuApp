//
//  orderListItem.swift
//  LayaAppVerson1
//
//  Created by 蔡勝宇 on 2022/10/16.
//

import Foundation

struct OrderListItem:Codable{
    let records:[Record4]
}
struct Record4:Codable{
    let id:String
    let createdTime:String
    let fields:Fields4
}
struct Fields4:Codable{
    let name:String
    let nameToppingMeal:String
    let nameWritingSomething:String
    let price:String
    
}


