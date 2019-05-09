//
//  Cell.swift
//  TripPlannerProject
//
//  Created by Wesley Espinoza on 5/7/19.
//  Copyright © 2019 HazeStudio. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class Cell: UICollectionViewCell {
    
    static var identifier: String = "Cell"
    
    var buttonLabel: UILabel!
    
    let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.isPitchEnabled = false
        map.isRotateEnabled = false
        map.isScrollEnabled = false
        map.isZoomEnabled = false
        map.layer.cornerRadius = 15
        return map
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        // Layout views inside the cell
        let tripToLabel = UILabel(frame: .zero)
        tripToLabel.translatesAutoresizingMaskIntoConstraints = false
        tripToLabel.text = "Trip To"
        self.contentView.addSubview(tripToLabel)
        
        
        let buttonLabel = UILabel(frame: .zero)
        buttonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(buttonLabel)
        self.contentView.addSubview(mapView)
        
        // Aplying constraints
        NSLayoutConstraint.activate([
            self.contentView.centerXAnchor.constraint(equalTo: buttonLabel.centerXAnchor),
            self.contentView.centerYAnchor.constraint(equalTo: buttonLabel.centerYAnchor, constant: 30),
            self.contentView.centerXAnchor.constraint(equalTo: tripToLabel.centerXAnchor, constant: 0),
            self.contentView.topAnchor.constraint(equalTo: tripToLabel.safeAreaLayoutGuide.topAnchor, constant: -10),
            self.contentView.bottomAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            self.contentView.leadingAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            self.contentView.trailingAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            self.contentView.topAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.topAnchor, constant: -100)
            ])
        // Customization
        self.isUserInteractionEnabled = true
        self.layer.cornerRadius = 15
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 10
        self.buttonLabel = buttonLabel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    @objc func viewDim(_ sender: UITapGestureRecognizer){
        self.alpha = 0.5
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.alpha = 0.5
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        self.alpha = 1
        
    }
    
}
