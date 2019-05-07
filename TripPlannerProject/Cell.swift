//
//  Cell.swift
//  TripPlannerProject
//
//  Created by Wesley Espinoza on 5/7/19.
//  Copyright © 2019 HazeStudio. All rights reserved.
//

import Foundation
import UIKit

class Cell: UICollectionViewCell {
    let colorArr:[String] = ["#35CDD8","#A5B557","#354E71"]
    
    static var identifier: String = "Cell"
    
    var buttonLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        // Layout views inside the cell
        
        let buttonLabel = UILabel(frame: .zero)
        buttonLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(buttonLabel)
        
        // Aplying constraints
        NSLayoutConstraint.activate([
            self.contentView.centerXAnchor.constraint(equalTo: buttonLabel.centerXAnchor),
            self.contentView.centerYAnchor.constraint(equalTo: buttonLabel.centerYAnchor),
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
