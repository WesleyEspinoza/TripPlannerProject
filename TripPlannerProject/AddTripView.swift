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

class AddTripViewController: UIViewController {
    
    var locationPredictions = [String]()
    
    var mapView = GMSMapView()
    
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonPressed)) as UIBarButtonItem
        navigationItem.title = "Add a Trip"
    }
    
    override func loadView() {
        
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        view.addSubview(resultTableView)
        
        NSLayoutConstraint.activate([
            resultTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            resultTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            resultTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            resultTableView.heightAnchor.constraint(equalToConstant: 150)])
        
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
    
    @objc func saveButtonPressed(){
        
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
                    let resultsStr = NSMutableString()
                    resultsStr.appendFormat("%@", result.attributedPrimaryText.string)
                    self.locationPredictions.append(resultsStr as String)
                }
                self.resultTableView.reloadData()
            }
        })
    }
}
extension AddTripViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        self.locationPredictions = [String]()
        placeAutocomplete(searchController.searchBar.text ?? "")
    }
}

extension AddTripViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationPredictions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTVC.Identifier, for: indexPath) as! CustomTVC
        cell.textLabel?.text = locationPredictions[indexPath.row]
        return cell
    }
}
extension AddTripViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
}
