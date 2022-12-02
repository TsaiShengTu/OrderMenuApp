//
//  orderList.swift
//  LayaAppVerson1
//
//  Created by 蔡勝宇 on 2022/10/16.
//

import Foundation

//整筆訂單陣列化

var orderSum = [orderMenu]()

//存取整筆訂單

struct orderMenu:Equatable,Codable{
    let itemName:String
    let priceSume:Int
    let toppingAndMeals:[String]
    let textField:String
    let itemNumber:Int
    let toppingAll:[String]
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let archiveURL = documentsDirectory.appendingPathExtension("orderList")
        .appendingPathExtension("plist")
        
    static func saveOrderList(orderList:[orderMenu]){
        let propertyListEncoder = PropertyListEncoder()
        let codedOrderList = try? propertyListEncoder.encode(orderList)
        try? codedOrderList?.write(to:archiveURL,options: .noFileProtection)
    }
    
    static func loadOrderList()-> [orderMenu]? {
        guard let codedOrderList = try? Data(contentsOf: archiveURL) else{ return nil }
        print(codedOrderList)
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<orderMenu>.self, from: codedOrderList)
    }

}


    
    


//單筆訂單


//保存data 使用usrdefalut?

