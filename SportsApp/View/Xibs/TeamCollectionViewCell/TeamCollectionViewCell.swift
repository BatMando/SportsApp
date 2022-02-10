//
//  TeamCollectionViewCell.swift
//  SportsApp
//
//  Created by admin on 1/29/22.
//  Copyright © 2022 admin. All rights reserved.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func displayTeamName(name : String){
        self.teamName.text = name
    }

    func displayTeamLogo(imageUrl : String){
        //print(imageUrl)
        self.teamLogo.kf.setImage(with: URL(string: imageUrl ))
    }

}
