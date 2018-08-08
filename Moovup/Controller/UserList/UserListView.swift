//
//  UserListView.swift
//  Moovup
//
//  Created by Moovup on 07/08/18.
//  Copyright © 2018 Moovup. All rights reserved.
//

import Foundation

protocol UserListView: class {
    func getUserListWithSuccess(users: [User])
    func finishUserListWithError(_ error: String?)
}
