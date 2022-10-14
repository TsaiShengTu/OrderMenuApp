//
//  Data.swift
//  LayaAppVerson1
//
//  Created by 蔡勝宇 on 2022/10/12.
//

import Foundation
import UIKit

struct DataShopitem: Codable{
    let records:[Record]
}
struct Record:Codable{
    let id:String
    let createdTime:String
    let fields:Fields
}
struct Fields:Codable {
    let shopName:String
    let shopAddress:String
    let shopCity:String
    let shopImage:[ShopImage]
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
