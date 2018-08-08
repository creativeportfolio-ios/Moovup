//
//  UserListPresenter.swift
//  Moovup
//
//  Created by Moovup on 07/08/18.
//  Copyright © 2018 Moovup. All rights reserved.
//

import Foundation
import CoreData

class UserListPresenter {
    
    let provider: UserListProvider
    weak private var userListView: UserListView?
    
    // MARK: - Initialization & Configuration
    init(provider: UserListProvider) {
        self.provider = provider
    }
    
    func attachView(view: UserListView?) {
        guard let view = view else { return }
        userListView = view
    }
    
    // MARK: - Perform Get User List
    func getUserList(showProgress: Bool) {
        provider.getUserList(showProgress: showProgress, successHandler: { (response) in
            
            CoreDataManager.sharedInstance.delete(entityName: Constant.userEntityName() as NSString)
            
            if response.count > 0 {
                for user: UsersModel in response {
                    _ = user.saveUserList()
                }
                
                let user = CoreDataManager.sharedInstance.fetch(entityName: Constant.userEntityName() as NSString) as! [User]
                self.userListView?.getUserListWithSuccess(users: user)
            }
            
        }, errorHandler: { (error) in
            self.userListView?.finishUserListWithError(error.localizedDescription == AlertMessage.errorType ? AlertMessage.noInternetMessage : error.localizedDescription)
        })
    }
}
