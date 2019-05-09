//
//  AddTripView.swift
//  TripPlannerProject
//
//  Created by Wesley Espinoza on 5/7/19.
//  Copyright © 2019 HazeStudio. All rights reserved.
//

import Foundation
import UIKit

class AddTripViewController: UIViewController {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "What city are we going to?"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textField: UITextField = {
       let searchBar = UITextField()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.layer.cornerRadius = 10
        searchBar.layer.borderWidth = 1
        searchBar.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: searchBar.frame.height))
        searchBar.leftViewMode = .always
        searchBar.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: searchBar.frame.height))
        searchBar.rightViewMode = .always
        return searchBar
    }()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.backgroundColor  = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonPressed)) as UIBarButtonItem
        navigationItem.title = "Add a Trip"
    }
    
     override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(titleLabel)
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -100),
            titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            
            textField.topAnchor.constraint(equalTo: titleLabel.safeAreaLayoutGuide.bottomAnchor, constant: 15),
            textField.heightAnchor.constraint(equalToConstant: 50),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25)])
        
    }
    
    @objc func saveButtonPressed(){
        
    }
}
