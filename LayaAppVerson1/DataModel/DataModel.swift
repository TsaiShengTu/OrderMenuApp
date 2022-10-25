//
//  DataModel.swift
//  LayaAppVerson1
//
//  Created by 蔡勝宇 on 2022/10/12.
//

import Foundation
public let apikey = "keyDPFR7Okan1NGGC"


class ShopItemController{
    static let shared = ShopItemController()
    let shopListUrl = URL(string: "https://api.airtable.com/v0/appk1fzVKpuilyG7v/shopList")!
    let shopSellUrl = URL(string: "https://api.airtable.com/v0/appk1fzVKpuilyG7v/shopSell?sort[][field]=name&sort[][direction]=asc")!
    let shopItemsUrl = URL(string: "https://api.airtable.com/v0/appk1fzVKpuilyG7v/shopListItems?sort[][field]=priceItem&sort[][direction]=desc")!
    let shopItemUrl2 = URL(string: "https://api.airtable.com/v0/appk1fzVKpuilyG7v/shopListItems1")!
    
    // @escaping脫逃，功能是函式完成後，參數還能使用
    //換句話說就是 強制直接引用
    // Result是 判斷 成功與否，後面加上成功的東西與Error
    // 不知道為什麼要回傳()
    func fetchshopList(completion: @escaping (Result<DataShopitem,Error>)->()){
        var request = URLRequest(url: shopListUrl)
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error
            in
            let decoder = JSONDecoder()
            if let data = data{
                do{
                    let shopListResponse = try decoder.decode(DataShopitem.self, from: data)
                    completion(.success(shopListResponse))
                }
                catch{
                    print(error)
                    completion(.failure(error))
                }
            }
            else if let error = error{
                completion(.failure(error))
            }
        }
        .resume()
    }
    func fetchshopSell(completion:@escaping(Result<DataShopSell,Error>)->()){
        var request = URLRequest(url:shopSellUrl)
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error
            in
            let decoder = JSONDecoder()
            if let data = data{
                do{
                    let shopSellResponse = try decoder.decode(DataShopSell.self, from: data)
//                    print(ShopItemController.shopLists)
                    completion(.success(shopSellResponse))
                }
                catch{
                    print(error)
                    completion(.failure(error))
                }
            }
        }
        .resume()
    }
    
    func fetchshopListItem(completion:@escaping(Result<DataShopItem,Error>)->()){
        var request = URLRequest(url:shopItemsUrl)
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error
            in
            let decoder = JSONDecoder()
            if let data = data{
                do{
                    let shopListitemResponse = try decoder.decode(DataShopItem.self, from: data)

                    completion(.success(shopListitemResponse))
                }
                catch{
                    print(error)
                    completion(.failure(error))
                }
            }
        }
        .resume()
    }
//    func fetchshopListItem2(completion:@escaping(Result<DataShopItem2,Error>)->()){
//        var request = URLRequest(url:shopItemUrl2)
//        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
//        URLSession.shared.dataTask(with: request) { data, response, error
//            in
//            let decoder = JSONDecoder()
//            if let data = data{
//                do{
//                    let shopListitemResponse = try decoder.decode(DataShopItem2.self, from: data)
//
//                    completion(.success(shopListitemResponse))
//                }
//                catch{
//                    print(error)
//                    completion(.failure(error))
//                }
//            }
//        }
//        .resume()
//    }
}
