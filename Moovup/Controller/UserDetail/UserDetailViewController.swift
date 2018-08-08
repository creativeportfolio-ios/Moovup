//
//  UserDetailViewController.swift
//  Moovup
//
//  Created by Moovup on 07/08/18.
//  Copyright © 2018 Moovup. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit

class UserDetailViewController: UIViewController {

    var userDetailTableView: UITableView!
    var headerMapView: GMSMapView!
    var user: User?
    let mapRange:Double = 1000
    let cellIdentifier = "userDetailCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createTableView()
        self.setupParallaxHeader()
        self.setNavigationBar()
    }
}

extension UserDetailViewController {
    func setNavigationBar() {
        self.title = self.user?.name ?? ""
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_back"), style: .plain, target: self, action: #selector(backClicked))
    }
    
    @objc func backClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func createTableView() {
        self.userDetailTableView = UITableView()
        self.view.addSubview(self.userDetailTableView)
        self.userDetailTableView.translatesAutoresizingMaskIntoConstraints = false
        self.userDetailTableView.backgroundColor = UIColor.groupTableViewBackground

        if #available(iOS 11.0, *) {
            self.userDetailTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0.0).isActive = true
            self.userDetailTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0.0).isActive = true
            self.userDetailTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true
            self.userDetailTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0.0).isActive = true
        } else {
            self.userDetailTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0.0).isActive = true
            self.userDetailTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
            self.userDetailTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true
            self.userDetailTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
        }
        self.userDetailTableView.dataSource = self
        self.userDetailTableView.delegate = self
        self.userDetailTableView.separatorStyle = .none
        self.userDetailTableView.register(UserDetailTableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
        self.userDetailTableView.reloadData()
    }
    
    func setupParallaxHeader() {
        self.headerMapView = GMSMapView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 250))
        let userLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: self.user?.latitude ?? 0.0, longitude: self.user?.longitude ?? 0.0)
        
        let range = self.translateCoordinate(coordinate: userLocation, metersLat: mapRange , metersLong: mapRange)
        
        let bounds = GMSCoordinateBounds(coordinate: userLocation, coordinate: range)
        let update = GMSCameraUpdate.fit(bounds, withPadding: 120.0)
        self.headerMapView.moveCamera(update)
        
        let marker = GMSMarker(position: userLocation)
        marker.map = self.headerMapView
        marker.icon = #imageLiteral(resourceName: "currentLocationMarker")
        
        self.userDetailTableView.parallaxHeader.view = self.headerMapView
        self.userDetailTableView.parallaxHeader.height = 250
        self.userDetailTableView.parallaxHeader.minimumHeight = 0
        self.userDetailTableView.parallaxHeader.mode = .topFill
        self.userDetailTableView.parallaxHeader.parallaxHeaderDidScrollHandler = { parallaxHeader in
        }
    }
    
    func translateCoordinate(coordinate: CLLocationCoordinate2D, metersLat: Double,metersLong: Double) -> (CLLocationCoordinate2D) {
        var rangeCoordinate = coordinate
        let span = MKCoordinateRegionMakeWithDistance(coordinate, metersLat, metersLong).span
        
        rangeCoordinate.latitude = coordinate.latitude + span.latitudeDelta
        rangeCoordinate.longitude = coordinate.longitude + span.longitudeDelta
        
        return rangeCoordinate
    }
}

extension UserDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as! UserDetailTableViewCell
        cell.configureCell(imageUrl: self.user?.imageUrl ?? "", userName: self.user?.name ?? "", email: self.user?.userEmail ?? "")
        return cell
    }
}
