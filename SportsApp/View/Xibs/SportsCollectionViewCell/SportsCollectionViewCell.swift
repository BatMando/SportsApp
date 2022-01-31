//
//  SportsCollectionViewCell.swift
//  SportsApp
//
//  Created by Sarah Nassrat  on 1/29/22.
//  Copyright © 2022 admin. All rights reserved.
//

import UIKit

class SportsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sportImage: UIImageView!
    @IBOutlet weak var sportName: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
        	
    }

    override func layoutSubviews() {
        super.layoutSubviews()
       // contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0))
//        sportImage.cornerRadius = 20
//        sportImage.clipsToBounds = true
    }
    
    
}
