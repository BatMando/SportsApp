//
//  SportsCollectionViewCell.swift
//  SportsApp
//
//  Created by Sarah Nassrat  on 1/29/22.
//  Copyright © 2022 admin. All rights reserved.
//

import UIKit
import Kingfisher

class SportsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sportImage: UIImageView!
    @IBOutlet weak var sportName: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    func displaySportName(name : String){
        self.sportName.text = name
    }
    
    func displayCellImage(imageUrl : String){
        self.sportImage.kf.setImage(with: URL(string: imageUrl ))
    }
    //    var model : SportModel? {
    //        didSet{
    //            guard let model = model else{return}
    //            self .sportName.text = model.strSport
    //            self.sportImage.kf.setImage(with: URL(string: model.strSportThumb ?? "" ))
    //        }
    //    }
    //
    
}
