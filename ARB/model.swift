//
//  model.swift
//  ARB
//
//  Created by DMITRIY DETKIN on 07/08/2019.
//  Copyright © 2019 DMITRIY DETKIN. All rights reserved.
//

import Foundation

struct roomList : Decodable {
    var roomName: String
    var roomName2: String
    var workType: String
    var workName: String
    var summPlan: Double
    var summFact: Double
    var recent: Double
    var budget: Double
    
    init (json: [String:Any]) {
        roomName = json["roomName"] as? String ?? ""
        roomName2 = json["roomName2"] as? String ?? ""
        workName = json["workName"] as? String ?? ""
        workType = json["workType"] as? String ?? ""
        summPlan = json["summPlan"] as? Double ?? 0.0
        summFact = json["summFact"] as? Double ?? 0.0
        recent = json["recent"] as? Double ?? 0.0
        budget = json["budget"] as? Double ?? 0.0
    }
}
var urlToData: URL {
    let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] + "/data.json"
    let urlPath = URL (fileURLWithPath: path)
    return urlPath
}

var rooms:[roomList] = []

//struct roomDetail {
//    var id: Int
//    var roomName: String
//    var workName: String
//    var workType: String
//    var units: String
//    var values: Double
//    var priseOne: Double
//    var summPlan: Double
//    var summFact: Double
//    var comment: String
//}

func getDataRoomList(jsonUrlString: String, dataLoaded: @escaping () -> Void) {
    rooms = []
    var returnArray:[roomList] = []
    
    guard let url = URL(string: jsonUrlString) else { return }
    
   let downloadTask = URLSession.shared.dataTask(with: url) {
    (datafs, response, error) in
        
        guard let data = datafs else { return}

        
        do {
            guard let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return }

            if let array = jsonData["databin"] as? [[String: Any]]
            {
                for dic in array
                {
                    let newRoom = roomList(json: dic)
                    returnArray.append(newRoom)
                }
//print(returnArray)
                rooms = returnArray
                DispatchQueue.main.async {
                    dataLoaded()
                }
                
                
            }
        } catch let jsonErr {
            print(jsonErr)
        }
    }
    downloadTask.resume()
    
}


func getDataRoomList2(jsonUrlString: String, dataLoaded: @escaping () -> Void) {
    rooms = []

    var returnArray:[roomList] = []
    
    guard let url = URL(string: jsonUrlString) else { return }
    let session = URLSession(configuration: .default)
    
    let downloadTask = session.downloadTask(with: url) {
        (urlfile, response, error) in
        if urlfile != nil {
            try? FileManager.default.removeItem(at: urlToData)
            try? FileManager.default.copyItem(at: urlfile!, to: urlToData)
//           print(urlToData)
            
            if let data = try? Data(contentsOf: urlToData) {
//print(data)
        
        do {
            guard let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return }
            
//            guard let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
            
//            print(jsonData)
            if let array = jsonData["databin"] as? [[String: Any]]
            {
                
                for dic in array
                {
                    let newRoom = roomList(json: dic)
                    returnArray.append(newRoom)
                }
                rooms = returnArray
                DispatchQueue.main.async {
                    dataLoaded()
                }
                
            }
        } catch let jsonErr {
            print(jsonErr)
        }
            }
            
        }
    }
    downloadTask.resume()
    
}

//func getDataRooms3(jsonUrlString: String, dataLoaded: @escaping () -> Void) {
//    rooms = []
//    let url = Bundle.main.url(forResource:jsonUrlString, withExtension: "json")!
//        let jsonData = try! Data(contentsOf: url)
//        rooms = try! JSONDecoder().decode([roomList].self, from: jsonData)
//}
