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
    
    var mapView = GMSMapView()
    

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
        
    }
    
     override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Where are we going?"
        navigationItem.searchController = searchController
        definesPresentationContext = true
      

        
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
                    print("Result \(result.attributedFullText) with placeID \(result.placeID)")
                }
            }
        })
    }
}
extension AddTripViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        placeAutocomplete(searchController.searchBar.text ?? "")
    }
}
