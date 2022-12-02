//
//  User.swift
//  LayaAppVerson1
//
//  Created by Sheng-Yu on 2022/11/1.
//

import Foundation

//這邊是先把使用者輸入的帳密 進行上傳

struct UserBody:Encodable{
    let user:User
}

struct User:Encodable{
    let login:String
    let password:String
    //登入 跟上傳有一些差別，是登入不需要email，所以用?型別
    var email:String?
}

struct UserResponse:Decodable{
    let userToken:String
    let login:String
    var email:String?
    
    enum CodingKeys:String,CodingKey{
        //這邊這樣寫是因為中間有一個斜槓，有這個方法可以準確輸入字串
        case userToken = "User-Token"
        case login
        case email
    }
}

struct ErrorResponse: Decodable {
    let errorCode: Int
    let message: String
}
