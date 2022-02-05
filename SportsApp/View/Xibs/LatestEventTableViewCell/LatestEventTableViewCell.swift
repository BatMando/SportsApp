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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
//    override func layoutSubviews() {
//           super.layoutSubviews()
//           contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0))
//       }
//    
}
