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
    var ID: Int
    var units: String
    var unitValue: Double
    var priseOne: Double
    
    init (json: [String:Any]) {
        roomName = json["roomName"] as? String ?? ""
        roomName2 = json["roomName2"] as? String ?? ""
        ID = json["id"] as? Int ?? 0
        workName = json["workName"] as? String ?? ""
        workType = json["workType"] as? String ?? ""
        summPlan = json["summPlan"] as? Double ?? 0.0
        summFact = json["summFact"] as? Double ?? 0.0
        recent = json["recent"] as? Double ?? 0.0
//        budget = json["budget"] as? Double ?? 0.0
        budget = summFact - summPlan
        units = json["units"] as? String ?? ""
        unitValue = json["values"] as? Double ?? 0.0
        priseOne = json["priseOne"] as? Double ?? 0.0
    }
}

struct payAll {
    var name: String
    var summ: Double
    
    init (json: [String:Any]) {
        name = json["user"] as? String ?? ""
        summ = json["summ"] as? Double ?? 0.0
    }
}

struct pay {
    var idpay: Int
    var date: String
    var user: String
    var type: String
    var summ: Double
    var comments: [String] = []
    
    init (json: [String:Any]) {
        idpay = json["idpay"] as? Int ?? 0
//        let datestr = json["date"] as? String ?? ""
//        let upperBound = datestr.index(datestr.startIndex, offsetBy: 10, limitedBy: datestr.endIndex) ?? datestr.endIndex
//        date = String(datestr[..<upperBound])
        var datestr = json["date"] as? String ?? "2019-10-09T21:00:00.000Z"
        let dateLocal = UTCToLocal(date: datestr)
        date = dateLocal
        user = json["user"] as? String ?? ""
        type = json["type"] as? String ?? ""
        summ = json["summ"] as? Double ?? 0.0
        comments = [json["comment"] as? String ?? ""]
    }
}

struct pay2 {
    var idpay: Int
    var date: String
    var user: String
    var type: String
    var summ: Double
    var comment: String
    
    init (json: [String:Any]) {
        idpay = json["idpay"] as? Int ?? 0
//        let datestr = json["date"] as? String ?? ""
//        let upperBound = datestr.index(datestr.startIndex, offsetBy: 10, limitedBy: datestr.endIndex) ?? datestr.endIndex
//        date = String(datestr[..<upperBound])
        var datestr = json["date"] as? String ?? ""
        let dateLocal = ""
        date = dateLocal
        user = json["user"] as? String ?? ""
        type = json["type"] as? String ?? ""
        summ = json["summ"] as? Double ?? 0.0
        comment = json["comment"] as? String ?? ""
    }
}

var pays:[pay] = []
var pays2:[pay2] = []
var paysAll:[payAll] = []

var urlToData: URL {
    let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] + "/data.json"
    let urlPath = URL (fileURLWithPath: path)
    return urlPath
}

var rooms:[roomList] = []
var rooms2:[roomList] = []
var savedMess: String = ""


struct roomDetail {
    var id: Int
    var roomName: String
    var workName: String
    var workType: String
    var summPlan: Double
    var summFact: Double
    var perc: Double
    var budget: Double
    var units: String
    var unitValue: Double
    var priseOne: Double
    
    init (json: [String:Any]) {
        id = json["id"] as? Int ?? 0
        roomName = json["roomName"] as? String ?? ""
        workName = json["workName"] as? String ?? ""
        workType = json["workType"] as? String ?? ""
        summPlan = json["summPlan"] as? Double ?? 0.0
        summFact = json["summFact"] as? Double ?? 0.0
        perc = json["perc"] as? Double ?? 0.0
//        budget = json["budget"] as? Double ?? 0.0
        budget = summFact - summPlan
        units = json["units"] as? String ?? ""
        unitValue = json["values"] as? Double ?? 0.0
        priseOne = json["priseOne"] as? Double ?? 0.0
    }
}
var room:[roomDetail] = []

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
func getDataPayAll(jsonUrlString: String, dataLoaded: @escaping () -> Void) {
    paysAll = []
    var returnArray:[payAll] = []
    
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
                    let newRoom = payAll(json: dic)
                    returnArray.append(newRoom)
                }
                paysAll = returnArray
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

func getDataPay(jsonUrlString: String, dataLoaded: @escaping () -> Void) {
    pays = []
    var returnArray:[pay] = []
    
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
                    let newRoom = pay(json: dic)
                    returnArray.append(newRoom)
                }
                pays = returnArray
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
func getDataPay2(jsonUrlString: String, dataLoaded: @escaping () -> Void) {
    pays2 = []
    var returnArray:[pay2] = []
    
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
                    let newRoom = pay2(json: dic)
                    returnArray.append(newRoom)
                }
                pays2 = returnArray
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

func getDataRoomDetail(jsonUrlString: String, dataLoaded: @escaping () -> Void) {
    room = []
    var returnArray:[roomDetail] = []
    
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
                    let newRoom = roomDetail(json: dic)
                    returnArray.append(newRoom)
                }
                //print(returnArray)
                room = returnArray
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

func uploadSaveData(jsonUrlString: String, dataLoaded: @escaping () -> Void) {
    
//    guard let url = URL(string: jsonUrlString) else { return }
    let url = URL(string: jsonUrlString)
    
    let downloadTask = URLSession.shared.dataTask(with: url!) {
        (datafs, response, error) in
        //print(error)
        
        guard let data = datafs else { return}
        
        do {
            guard let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return }
            
            if let array = jsonData["databin"] as? [[String: Any]]
            {
//                print(array)
                for dic in array
                {
                    savedMess = (dic["message"] as? String)!
//                    print(dic["message"])
//                    returnArray.append(newRoom)
                }
                //print(returnArray)
//                room = returnArray
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
func deletePay(jsonUrlString: String, dataLoaded: @escaping () -> Void) {
    
        guard let url = URL(string: jsonUrlString) else { return }
    
    let downloadTask = URLSession.shared.dataTask(with: url) {
        (datafs, response, error) in
        //print(error)
        
        guard let data = datafs else { return}
        
        do {
            guard let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return }
            
            if let array = jsonData["databin"] as? [[String: Any]]
            {
                //                print(array)
                for dic in array
                {
                    savedMess = (dic["message"] as? String)!
                    //                    print(dic["message"])
                    //                    returnArray.append(newRoom)
                }
                //print(returnArray)
                //                room = returnArray
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
