//
//  Constant.swift
//  Moovup
//
//  Created by Moovup on 07/08/18.
//  Copyright © 2018 Moovup. All rights reserved.
//

import Foundation
import UIKit

class Constant: NSObject {
    class func baseURL() -> String {
        return "http://www.json-generator.com/api/json/"
    }
    
    class func googleMapKey() -> String {
        return "AIzaSyAa9OlE1PdqPHBY54r1DfSIxWeqEoJr3X4"
    }
    
    class func userEntityName() -> String {
        return "User"
    }
    
    class func appName() -> String {
        return "Moovup"
    }
}

struct AppColor {
    static let themeColor = UIColor(red: 69/255.0, green: 182/255.0, blue: 83/255.0, alpha: 1.0)
    static let evenrowColor = UIColor(red: 234/255.0, green: 234/255.0, blue: 234/255.0, alpha: 1.0)
    static let oddrowColor = UIColor(red: 60/255.0, green: 179/255.0, blue: 113/255.0, alpha: 1.0)
}

struct AlertMessage {
    static let noInternetMessage = "There is no internet connection. Please try again later"
    static let ok = "Ok"
    static let errorType = "The operation couldn’t be completed. (Moovup.NetworkError error 6.)"
}
