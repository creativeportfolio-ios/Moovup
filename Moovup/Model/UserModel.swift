//
//  UserModel.swift
//  Moovup
//
//  Created by Moovup on 07/08/18.
//  Copyright © 2018 Moovup. All rights reserved.
//

import Foundation
import ObjectMapper
import CoreData

class UsersModel: Mappable {
    
    let managedContext = CoreDataManager.sharedInstance.getManagedContext()

    var location: LocationModel?
    var imageUrl: String?
    var userId: String?
    var userName: String?
    var email: String?
    
    required init?(map: Map) {
    }
    
    required init?() {
    }
    
    func mapping(map: Map) {
        location <- map["location"]
        imageUrl <- map["picture"]
        userId <- map["_id"]
        userName <- map["name"]
        email <- map["email"]
    }
    
    func saveUserList() -> User  {
        let entity = NSEntityDescription.entity(forEntityName: Constant.userEntityName(), in: managedContext)!
        let userObject: User = NSManagedObject(entity: entity, insertInto: managedContext) as! User
        
        userObject.imageUrl = self.imageUrl
        userObject.userEmail = self.email
        userObject.name = self.userName
        userObject.userId = self.userId
        userObject.latitude = self.location?.latitude ?? 0.0
        userObject.longitude = self.location?.longitude ?? 0.0
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return userObject

    }
}

class LocationModel: Mappable {
    var latitude: Double?
    var longitude: Double?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        latitude <- map["latitude"]
        longitude <- map["longitude"]
    }

}
