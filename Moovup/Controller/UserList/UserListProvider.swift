//
//  UserListProvider.swift
//  Moovup
//
//  Created by Moovup on 07/08/18.
//  Copyright © 2018 Moovup. All rights reserved.
//

import Foundation
import ObjectMapper

class UserListProvider {
    func getUserList(showProgress: Bool, successHandler: @escaping (_ response: [UsersModel]) -> Void,
                     errorHandler: @escaping (_ error: Error) -> Void) {
        
        NetworkManager.makeJSONObjectArrayRequest(MoovupHttpRouter.getUserList(), message: showProgress ? "Loading..." : "" , showProgress: showProgress)
            .onSuccess { (response) in
                if response.count > 0{
                    let userList = Mapper<UsersModel>().mapArray(JSONArray:response)
                    successHandler(userList)
                }
            }
            .onFailure { (error) in
                errorHandler(error)
                print(error.localizedDescription)
            }
            .onComplete { _ in
                
        }
    }
}
