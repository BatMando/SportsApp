//
//  UpcomingEventCollectionViewCell.swift
//  SportsApp
//
//  Created by admin on 1/29/22.
//  Copyright © 2022 admin. All rights reserved.
//

import UIKit

class UpcomingEventCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
   override func layoutSubviews() {
            super.layoutSubviews()
            contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
        }
     

}
