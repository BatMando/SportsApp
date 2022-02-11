//
//  LeaguesTableViewCell.swift
//  SportsApp
//
//  Created by Mohamed Ahmed on 30/01/2022.
//  Copyright © 2022 admin. All rights reserved.
//

import UIKit
import Toaster

class LeaguesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var favouriteBtnImage: UIButton!

    var youtubeAction : (()->())?
    
    
    func displayLeagueName(name : String){
        self.leagueName.text = name
    }
    
    func displayCellImage(imageUrl : String){
        self.leagueImage.kf.setImage(with: URL(string: imageUrl ))
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
    }
    
    @IBAction func pressFavouriteBtn(_ sender: UIButton) {
        youtubeAction?()
    }
}

