//
//  UserModel.swift
//  AlamofireDemo
//
//  Created by Dheeraj Arora on 23/11/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserInfo {
    var id = Int()
    var name = String()
    var email = String()
    var phone = String()
    var password = String()
    var deviceId = Int()
    var device = String()
    var token = String()
    var status = String()
    var createdAt = String()
    var updatedAt = String()
    
    init(userInfo: JSON) {
        self.id = userInfo["id"].intValue
        self.name = userInfo["name"].stringValue
        self.email = userInfo["email"].stringValue
        self.phone = userInfo["phone"].stringValue
        self.password = userInfo["password"].stringValue
        self.deviceId = userInfo["deviceId"].intValue
        self.token = userInfo["token"].stringValue
        self.status = userInfo["status"].stringValue
        self.createdAt = userInfo["createdAt"].stringValue
        self.updatedAt = userInfo["updatedAt"].stringValue
        
        
    }
    
}
class UserModel {
    
    var name = String()
    var username = String()
    var email = String()
    var phone = String()
    var address: UserAddress?
    var company: UserCompany?
    
    init(userJson: JSON) {
        self.name = userJson["name"].stringValue
        self.username = userJson["username"].stringValue
        self.email = userJson["email"].stringValue
        self.phone = userJson["phone"].stringValue
        self.address = UserAddress(addressJson: userJson["address"])
        self.company = UserCompany(companyJson: userJson["company"])
    }
    
}

class UserAddress {
     var street = String()
     var suite = String()
     var city = String()
     var zipcode = String()
    var geo: Geo?
    
    init(addressJson: JSON) {
        self.street = addressJson["street"].stringValue
        self.suite = addressJson["suite"].stringValue
        self.city = addressJson["city"].stringValue
        self.zipcode = addressJson["zipcode"].stringValue
        self.geo = Geo(geoJson: addressJson["geo"])
    }
    
}
class Geo {
    var lat = String()
    var lng = String()
    
    init(geoJson: JSON) {
         self.lat = geoJson["lat"].stringValue
         self.lng = geoJson["lng"].stringValue
    }
    
}

class UserCompany {
     var companyName = String()
     var catchPhrase = String()
     var bs = String()
    
    init(companyJson: JSON) {
        self.companyName = companyJson["name"].stringValue
        self.catchPhrase = companyJson["catchPhrase"].stringValue
        self.bs = companyJson["bs"].stringValue
    }
    
}
