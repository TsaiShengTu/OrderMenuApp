//
//  Data.swift
//  LayaAppVerson1
//
//  Created by 蔡勝宇 on 2022/10/12.
//

import Foundation
import UIKit


//商家資料
//包含收藏
struct DataShopitem: Codable{
    let records:[Record]
}
struct Record:Codable{
    let id:String
    let createdTime:String
    let fields:Fields
}
struct Fields:Codable {
    var shopName:String
    let shopAddress:String
    let shopCity:String
    var heart:Bool?
    let shopImage:[ShopImage]
    let phoneNumber:String
    let shopTime:String
    let shopAppCode:String
    let shopTakeInTime:String
    let latitude:String
    let longitude:String
    
    static let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let url = documentDirectory.appendingPathComponent("items").appendingPathExtension("json")
    
    static func saveHeartData(saveheart:[Fields]){
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(saveheart) else{ return }
        try? data.write(to: url)
    }
    static func loadHeartData()->[Fields]?{
        guard let data = try? Data(contentsOf: url) else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode([Fields].self, from: data)
    }
    
}
struct ShopImage:Codable{
    let url:URL
}



struct IndexList{
    let listName:String
    let listImage:String
    
    static func loadListData0() -> [IndexList] {
        let indexList1 = IndexList(listName: "系統資訊", listImage: "checkmark.shield")
        let indexList2 = IndexList(listName: "隱私權政策", listImage: "rectangle.badge.checkmark")
        let indexList3 = IndexList(listName: "使用條款", listImage: "text.badge.checkmark.rtl")
        return [indexList1,indexList2,indexList3]
        
    }
    
    static func loadListData1() -> [IndexList] {
        let indexList1 = IndexList(listName: "基本資料", listImage:"person.circle")
        let indexList2 = IndexList(listName: "歷史紀錄", listImage: "newspaper.fill")
        let indexList3 = IndexList(listName: "常去店家", listImage: "suit.heart")
        let indexList4 = IndexList(listName: "回首頁", listImage: "")
        return [indexList1,indexList2,indexList3,indexList4]
        
    }
    static func loadListData2() -> [IndexList] {
        
        let indexList1 = IndexList(listName: "門市資訊", listImage: "house")
        let indexList2 = IndexList(listName: "最新消息", listImage: "newspaper")
        let indexList3 = IndexList(listName: "系統資訊", listImage: "checkmark.shield")
        let indexList4 = IndexList(listName: "隱私權政策", listImage: "rectangle.badge.checkmark")
        let indexList5 = IndexList(listName: "使用條款", listImage: "text.badge.checkmark.rtl")
        return [indexList1,indexList2,indexList3,indexList4,indexList5]
        
    }
}



//以下是收藏的struct
//struct collectionShopes:Equatable,Codable{
//    //所有的資料
//    var AllVocs = [collectionShop]()
//    //收藏的資料
//    var collectedVocs = [collectionShop]()
//
//    //下載
//     func load() -> [collectionShop]?{
//        UserDefaults.standard.object(forKey: "save") as? [collectionShop]
//    }
//    //存取
//     func save(item:[collectionShop]){
//        UserDefaults.standard.set(item, forKey: "save")
//    }
//
//    //加取 收藏的函式
//    //兩個參數，如果是true 就收藏進去 所有的資料
//    mutating func collectShop(isCollected:Bool,allCollect:collectionShop){
//        //陣列的索引值為0
//        var index = 0
//        if isCollected{
//            collectedVocs.append(allCollect)
//        }
//        else{
//            //檢查所有的資料 有無收藏，如果有
//            if collectedVocs.contains(allCollect){
//                // MARK: 這邊看不懂
//                while collectedVocs[index] != allCollect{
//                    index += 1
//                }
//                //移除
//                collectedVocs.remove(at: index)
//            }
//        }
//    }
//
//
//
//}


//店家本地端資料
struct collectionShop:Equatable,Codable{
    var shopName:String
    let address:String
    let pic:String
    var heart = false
    
    static func saveOrderList(orderList:[collectionShop]){
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(orderList) else{ return }
        let userdefaults = UserDefaults.standard
        userdefaults.set(data, forKey: "orderList")
    }
    static func loadOrderList() -> [collectionShop]?{
        guard let data = UserDefaults.standard.data(forKey: "orderList") else{ return nil}
        let decoder = JSONDecoder()
        return try? decoder.decode([collectionShop].self, from: data)
    }
    
    
    
    
}



enum CollectionShopCity:Int{
    case jilong
    case tapie
}
