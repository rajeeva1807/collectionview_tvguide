//
//  decorationview.swift
//  customlayout_collectionview
//
//  Created by Rajeeva Ranjan on 14/10/20.
//  Copyright © 2020 Rajeeva Ranjan. All rights reserved.
//

import Foundation
import UIKit

class decorationview: UICollectionReusableView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightGray
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.zPosition = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


