//
//  AddTripView.swift
//  TripPlannerProject
//
//  Created by Wesley Espinoza on 5/7/19.
//  Copyright © 2019 HazeStudio. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class AddTripViewController: UIViewController {
    let locationManager = CLLocationManager()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Where are we going?"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let mapView: MKMapView = {
       let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    let searchController: UISearchController = {
       let searchBar = UISearchController()
        searchBar.searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        return searchBar
    }()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.backgroundColor  = .white
    }
    
    
     override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        view.addSubview(titleLabel)
        view.addSubview(mapView)
        view.addSubview(searchController)
        
        NSLayoutConstraint.activate([titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            mapView.heightAnchor.constraint(equalToConstant: 300),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15)])
        
    }
}
extension AddTripViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("location: \(location)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
    }
}
