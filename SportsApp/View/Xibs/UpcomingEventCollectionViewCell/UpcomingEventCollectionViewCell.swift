//
//  UpcomingEventCollectionViewCell.swift
//  SportsApp
//
//  Created by admin on 1/29/22.
//  Copyright © 2022 admin. All rights reserved.
//

import UIKit

class UpcomingEventCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var eventThumbnail: UIImageView!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var awayTeamName: UILabel!
    @IBOutlet weak var homeTeamLogo: UIImageView!
    @IBOutlet weak var awayTeamLogo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
   override func layoutSubviews() {
            super.layoutSubviews()
          // contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
        }
    
    
    func displayEventDate(date : String){
        self.eventDate.text = date
    }
    func displayEventTime(time : String){
        self.eventTime.text = time
    }
    func displayEventThumbnail(imageUrl : String){
        
        guard imageUrl != "" else {
            displayPlaceHolderImage()
            return
        }
        self.eventThumbnail.kf.setImage(with: URL(string: imageUrl ))
        
    }
    func displayPlaceHolderImage(){
        self.eventThumbnail.image = UIImage(named: "latestEventsCellBG")
    }
    func displayHomeTeamName(name : String){
        self.homeTeamName.text = name
    }
    func displayAwayTeamName(name : String){
        self.awayTeamName.text = name
    }
    
    func displayHomeTeamLogo(imageUrl : String?){
        guard let logoUrl = imageUrl,!imageUrl!.isEmpty else{
            self.homeTeamLogo.image = UIImage(named: "logoPlaceHolder")
            return
        }
        self.homeTeamLogo.kf.setImage(with: URL(string: logoUrl ))
    }
    
    func displayAwayTeamLogo(imageUrl : String?){
        guard let logoUrl = imageUrl,!imageUrl!.isEmpty else{
            self.awayTeamLogo.image = UIImage(named: "logoPlaceHolder")
            return
        }
        self.awayTeamLogo.kf.setImage(with: URL(string: logoUrl ))
    }
}
