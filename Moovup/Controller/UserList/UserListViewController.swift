//
//  UserListController.swift
//  Moovup
//
//  Created by Moovup on 07/08/18.
//  Copyright © 2018 Moovup. All rights reserved.
//

import UIKit
import CoreData

class UserListViewController: UIViewController {
    
    var tableView: UITableView!
    let userPresenter = UserListPresenter(provider: UserListProvider())
    var userList = [User]()
    let cellIdentifier = "userCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        self.userPresenter.attachView(view: self)
        self.createTableView()
        self.getOfflineUser()
    }
}

extension UserListViewController {
    func setNavigationBar() {
        self.title = "Users"

        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.barTintColor = AppColor.themeColor
    }
    
    func createTableView() {
        self.tableView = UITableView()
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.backgroundColor = UIColor.groupTableViewBackground
        
        if #available(iOS 11.0, *) {
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0.0).isActive = true
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0.0).isActive = true
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0.0).isActive = true
        } else {
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0.0).isActive = true
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
        }
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        self.tableView.register(UserTableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
        self.tableView.sectionFooterHeight = 8.0
        self.tableView.estimatedSectionFooterHeight = 1.0
        self.tableView.reloadData()
    }
    
    func getOfflineUser() {
        userList = CoreDataManager.sharedInstance.fetch(entityName: Constant.userEntityName() as NSString) as! [User]
        self.userPresenter.getUserList(showProgress: userList.count > 0 ? false : true)
        tableView.reloadData()
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: Constant.appName(), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: AlertMessage.ok, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as! UserTableViewCell
        let user = self.userList[indexPath.row]
        cell.configureCell(imageUrl: user.imageUrl ?? "", userName: user.name ?? "", indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userDetailViewController = UserDetailViewController()
        userDetailViewController.user = self.userList[indexPath.row]
        self.navigationController?.pushViewController(userDetailViewController, animated: true)
    }
}

extension UserListViewController: UserListView {
    func getUserListWithSuccess(users: [User]) {
        self.userList = users
        self.tableView.reloadData()
    }
    
    func finishUserListWithError(_ error: String?) {
        self.showAlert(message: error!)
    }
}
