//
//  CustomFlowLayout.swift
//  TripPlannerProject
//
//  Created by Wesley Espinoza on 5/7/19.
//  Copyright © 2019 HazeStudio. All rights reserved.
//

import Foundation
import UIKit

class CustomFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        guard let cv = collectionView else { return }
        let availableWidth = cv.bounds.inset(by: cv.layoutMargins).size.width
        let minColumnWidth = CGFloat(300)
        let maxNumColumns = Int(availableWidth/minColumnWidth)
        let cellWidth = (availableWidth / CGFloat(maxNumColumns).rounded(.down))
        
        self.itemSize = CGSize(width: cellWidth, height: 70.0)
        self.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.sectionInsetReference = .fromSafeArea
        
    }
    
}
