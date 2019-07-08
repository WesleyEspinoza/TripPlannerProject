//
//  TripViewController.swift
//  TripPlannerProject
//
//  Created by Wesley Espinoza on 7/1/19.
//  Copyright © 2019 HazeStudio. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class TripViewController: UIViewController {
    public var tripName: String!
    
    var mainTrip: Trip!
    var managedContext = CoreDataManager.managedContext
    
    weak var tableView: UITableView!
    
    let tripTitle: UILabel =  {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        
        return title
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Waypoint", style: .plain, target: self, action: #selector(saveButtonPressed)) as UIBarButtonItem
        navigationItem.title = "WayPoints"
        if let name = self.tripName{
            tripTitle.text = "Trip to \(name)"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        self.view.addSubview(tripTitle)
        
        NSLayoutConstraint.activate([
            self.view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: tripTitle.topAnchor, constant: 0),
            self.view.leadingAnchor.constraint(equalTo: tripTitle.leadingAnchor),
            self.view.trailingAnchor.constraint(equalTo: tripTitle.trailingAnchor),
            
            self.view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: tableView.topAnchor, constant: -100),
            self.view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            self.view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            self.view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            
            ])
        self.tableView = tableView
        
        
        
        if let name = self.tripName{
            
            let tripSearch: NSFetchRequest<Trip> = Trip.fetchRequest()
            tripSearch.predicate = NSPredicate(format: "%K == %@", #keyPath(Trip.names), name)
            
            do {
                let results = try managedContext.fetch(tripSearch)
                if results.count > 0 {
                    mainTrip = results.first
                    
                } else {
                    mainTrip = Trip(context: managedContext)
                    mainTrip?.names = name
                    try managedContext.save()
                }
            } catch let error as NSError {
                print("Error: \(error) description: \(error.userInfo)")
            }
        }
        
        tableView.reloadData()
    }
    
    
    
    
    @objc func saveButtonPressed(){
        let addWayPoint = AddWayPointViewController()
        
        addWayPoint.mainTrip = mainTrip
        
        navigationController?.pushViewController(addWayPoint, animated: true)
        
    }
}

extension TripViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainTrip.wayPoints!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let items = mainTrip.wayPoints?.array as! [WayPoint]
        cell.textLabel?.text = items[indexPath.row].name
        return cell
    }
}
