//
//  AddTripView.swift
//  TripPlannerProject
//
//  Created by Wesley Espinoza on 5/7/19.
//  Copyright © 2019 HazeStudio. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import GooglePlaces
import CoreData



class AddWayPointViewController: UIViewController, CLLocationManagerDelegate {
    public var mainTrip: Trip!
    var selectedPlace: GMSPlace?
    
    let managedContext = CoreDataManager.managedContext
    
    var locationPredictions = [GMSAddress]() {
        didSet {
            resultTableView.reloadData()
        }
    }
    var placeName: String = ""
    var waypointLat: Double = 0
    var waypointLong: Double = 0
    
    var mapView = GMSMapView()
    var locationManager = CLLocationManager()
    
    let resultTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        return table
    }()
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "What city are we going to?"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let searchController: UISearchController = {
        let searchBar = UISearchController(searchResultsController: nil)
        searchBar.searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.backgroundColor  = .white
        navigationItem.title = "Add a Waypoint"
        
    }
    
    override func loadView() {
        
        
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 0.05, longitude: 0.05, zoom: 2.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        
        view.addSubview(resultTableView)
        
        NSLayoutConstraint.activate([
            resultTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            resultTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            resultTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            resultTableView.heightAnchor.constraint(equalToConstant: 150)])
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        
        self.mapView.animate(to: camera)
        
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Where are we going?"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        self.resultTableView.register(CustomTVC.self, forCellReuseIdentifier: CustomTVC.Identifier)
        
        self.resultTableView.dataSource = self
        self.resultTableView.delegate = self
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        @unknown default:
            fatalError()
        }
    }
    
    func saveButtonPressed(lat: Double, long: Double){
        let wayPoint = WayPoint(context: managedContext)
        
        wayPoint.lat = lat
        wayPoint.long = long
        
        
        
        if let trip = mainTrip, let wayPoints = trip.wayPoints?.mutableCopy() as? NSMutableOrderedSet {
            wayPoints.add(wayPoint)
            
            trip.wayPoints = wayPoints
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error: \(error), description: \(error.userInfo)")
        }
    }
    
    func placeAutocomplete(_ string: String) {
        let visibleRegion = mapView.projection.visibleRegion()
        let bounds = GMSCoordinateBounds(coordinate: visibleRegion.farLeft, coordinate: visibleRegion.nearRight)
        
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        let placesClient = GMSPlacesClient()
        placesClient.autocompleteQuery(string, bounds: bounds, filter: filter, callback: {
            (results, error) -> Void in
            guard error == nil else {
                print("Autocomplete error \(String(describing: error))")
                return
            }
            if let results = results {
                for result in results {
                    placesClient.lookUpPlaceID(result.placeID, callback: {
                        (place, error) -> Void in
                        // Get place.coordinate
                        GMSGeocoder().reverseGeocodeCoordinate(place!.coordinate, completionHandler: {
                            (response, error) -> Void in
                            
                            for addObj in response!.results()! {
                                self.locationPredictions.append(addObj)
                            }
                        })
                    })
                    
                }
            }
        })
    }
}

extension AddWayPointViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        self.locationPredictions = [GMSAddress]()
        placeAutocomplete(searchController.searchBar.text ?? "")
    }
    
    
    
    
    
}


extension AddWayPointViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "WayPoint", message: "are you sure you want to add a way point here?", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "name the waypoint"
        }
        
        let save = UIAlertAction(title: "save", style: .default) { (alertAction) in
            let newWaypoint = NSEntityDescription.insertNewObject(forEntityName: "WayPoint", into: self.managedContext) as! WayPoint
            
            newWaypoint.lat = self.locationPredictions[indexPath.row].coordinate.latitude
            newWaypoint.long = self.locationPredictions[indexPath.row].coordinate.longitude
            self.mainTrip.addToWayPoints(newWaypoint)
//
            CoreDataManager.saveTrip()
            print(newWaypoint)
            
        }
        
        alert.addAction(save)
        
        self.present(alert, animated: true) {
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationPredictions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTVC.Identifier, for: indexPath) as! CustomTVC
        cell.textLabel?.text = locationPredictions[indexPath.row].lines![0]
        return cell
    }
}

extension AddWayPointViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
