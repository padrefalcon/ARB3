//
//  ServerManager.swift
//  Appartments
//
//  Created by DMITRIY DETKIN on 29/07/2019.
//  Copyright © 2019 DMITRIY DETKIN. All rights reserved.
//

import Foundation
//import Alamofire
//import SwiftyJSON
//
//class ServerManager {
//    static let shared = ServerManager()
//    private init() {}
//    func fetchMainData(closure: @escaping (DefaultDataResponse) -> Void) {
//        let url = "http://89.223.26.123:7777/1"
//        let dataRequest = Alamofire.request(url)
//        
//        dataRequest.responseData { (response) in
//            if let data = response.data, let json = try? JSON(data: data) {
//                closure(try! JSONDecoder().decode(DefaultDataResponse.self, from: try! json.rawData()))
//            }
//        }
//        
//    }
//    
//    func fetchSecondData(closure: @escaping (DefaultDataResponse) -> Void) {
//        let url = "http://89.223.26.123:7777/2"
//        let dataRequest = Alamofire.request(url)
//        
//        dataRequest.responseData { (response) in
//            if let data = response.data, let json = try? JSON(data: data) {
//                closure(try! JSONDecoder().decode(DefaultDataResponse.self, from: try! json.rawData()))
//            }
//        }
//        
//    }
//}
