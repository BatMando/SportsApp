//
//  LeaguesTableViewCell.swift
//  SportsApp
//
//  Created by Mohamed Ahmed on 30/01/2022.
//  Copyright © 2022 admin. All rights reserved.
//

import UIKit

class LeaguesTableViewCell: UITableViewCell {

    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var leagueName: UILabel!
    
    @IBOutlet weak var favouriteBtnImage: UIButton!
    
    var model : LeagueModel? {
        didSet{
            guard let model = model else {
                return
            }
            self.leagueName.text = model.strLeague
//            self.leagueImage.setImage("youtube_icn", forState: UIControlState.Normal)
    
            self.leagueImage.kf.setImage(with: URL(string:model.strBadge ?? "" ))
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
    }
    
    
    
    @IBAction func pressFavouriteBtn(_ sender: UIButton) {
    }
}
