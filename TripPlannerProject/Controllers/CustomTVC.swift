//
//  TableViewCustomCell.swift
//  TripPlannerProject
//
//  Created by Wesley Espinoza on 5/9/19.
//  Copyright © 2019 HazeStudio. All rights reserved.
//

import Foundation
import UIKit

class CustomTVC: UITableViewCell {
    
    static let Identifier = "CustomCell"
    
    weak var titleLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initialize()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initialize()
    }
    
    func initialize() {
        
        let titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(titleLabel)
        self.titleLabel = titleLabel
        self.titleLabel.textAlignment = .center
        self.titleLabel.center = self.contentView.center
        
        self.titleLabel.font = UIFont.systemFont(ofSize: 64)
        self.backgroundColor = .clear
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
}
