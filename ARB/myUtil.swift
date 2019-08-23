//
//  myUtil.swift
//  ARB
//
//  Created by DMITRIY DETKIN on 09/08/2019.
//  Copyright © 2019 DMITRIY DETKIN. All rights reserved.
//

import Foundation

func separatedNumber(_ number: Any) -> String {
    guard let itIsANumber = number as? NSNumber else { return "Not a number" }
    let formatter = NumberFormatter()
    //formatter.generatesDecimalNumbers = true
    //formatter.positivePrefix = "+"
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 0
    formatter.numberStyle = .decimal
    formatter.groupingSeparator = " "
    formatter.decimalSeparator = ","
    return formatter.string(from: itIsANumber)!
}

extension String {
    var URLEncoded:String {
        let unreservedChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~"
        let unreservedCharset = NSCharacterSet(charactersIn: unreservedChars)
        let encodedString = self.addingPercentEncoding(withAllowedCharacters: unreservedCharset as CharacterSet)
        return encodedString ?? self
    }
}


func convertDateFormatter(date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-ddTHH:mm:ss"//this your string date format
    dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
    dateFormatter.locale = Locale(identifier: "your_loc_id")
    let convertedDate = dateFormatter.date(from: date)
    
    guard dateFormatter.date(from: date) != nil else {
        assert(false, "no date from string")
        return ""
    }
    
    dateFormatter.dateFormat = "yyyy MMM HH:mm EEEE"///this is what you want to convert format
    dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
    let timeStamp = dateFormatter.string(from: convertedDate!)
    
    return timeStamp
}

func UTCToLocal(date:String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    
    let dt = dateFormatter.date(from: String(date.dropLast(5)))
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    return dateFormatter.string(from: dt!)
}
