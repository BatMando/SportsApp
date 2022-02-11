//
//  LatestEventTableViewCell.swift
//  SportsApp
//
//  Created by admin on 1/29/22.
//  Copyright © 2022 admin. All rights reserved.
//

import UIKit

class LatestEventTableViewCell: UITableViewCell {
    @IBOutlet weak var eventThumbnail: UIImageView!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventResult: UILabel!
    @IBOutlet weak var eventStatus: UILabel!
    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var awayTeamName: UILabel!
    @IBOutlet weak var homeTeamLogo: UIImageView!
    @IBOutlet weak var awayTeamLogo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
    func displayEventDate(date : String){
        self.eventDate.text = date
    }
    func displayEventTime(time : String){
        self.eventTime.text = time
    }
    func displayEventStatus(status : String){
        self.eventStatus.text = status
    }
    func displayEventResult(result : String){
        self.eventResult.text = result
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
