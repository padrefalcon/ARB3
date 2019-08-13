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
//    formatter.minimumFractionDigits = 2
    formatter.numberStyle = .decimal
    formatter.groupingSeparator = " "
    formatter.decimalSeparator = ","
    return formatter.string(from: itIsANumber)!
}
