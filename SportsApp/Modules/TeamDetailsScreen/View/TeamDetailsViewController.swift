//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by admin on 1/28/22.
//  Copyright © 2022 admin. All rights reserved.
//

import UIKit
import Kingfisher

class TeamDetailsViewController:  BaseViewController ,TeamDetailsViewControllerProtocol{
    // MARK: -IBOutlet
    @IBOutlet weak var stadiumImageView: UIImageView!
    @IBOutlet weak var teamNameLabell: UILabel!
    @IBOutlet weak var teamLogoImageView: UIImageView!
    @IBOutlet weak var stadiumNameLabel: UILabel!
    @IBOutlet weak var teamGersyImageView: UIImageView!
    
    // MARK: -Properties
    var teamDetailsPresenter : TeamDetailsPresenterProtocol!
    var team : TeamModel?
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        displayTeamDetails()
    }
    
    // MARK: - Methods
    func displayTeamDetails(){
        team = teamDetailsPresenter.getTeam()
        guard let team = team else {return}
        teamNameLabell.text = team.strTeam
        stadiumNameLabel.text = team.strStadium
        
        if team.strTeamBadge != nil {
            self.teamLogoImageView.kf.setImage(with: URL(string: team.strTeamBadge ?? "" ))
        }
        else {
            self.teamLogoImageView.image = UIImage(named: "logoPlaceHolder")
        }
        
        
        if team.strTeamJersey != nil{
            self.teamGersyImageView.kf.setImage(with: URL(string: team.strTeamJersey ?? "" ))
        }
        else {
            self.teamGersyImageView.image = UIImage(named: "kitplaceHolder")
        }
        
        
        if team.strStadiumThumb != nil {
            self.stadiumImageView.kf.setImage(with: URL(string: team.strStadiumThumb ?? "" ))
            
        }
        else {
            self.stadiumImageView.image = UIImage(named: "stadiumPlaceHolder")
            
        }
        
        
    }
    
    
    // MARK: - IBAction
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func navigateToOfficialWebsite(_ sender: UIButton) {
        openLink(url: team?.strWebsite)
        
        //        guard let officialWebSite = team?.strWebsite else{return}
        //        if let url = URL(string: "https://\(officialWebSite)") {
        //        UIApplication.shared.open(url)}
    }
    
    @IBAction func visitFacebookPage(_ sender: UIButton) {
        openLink(url: team?.strFacebook)
    }
    
    @IBAction func visitTwitterChannel(_ sender: UIButton) {
        openLink(url: team?.strTwitter)
    }
    
    @IBAction func visitInstagramPage(_ sender: UIButton) {
        openLink(url: team?.strInstagram)
        
    }
    
    @IBAction func visitYoutubeChannel(_ sender: UIButton) {
        openLink(url: team?.strYoutube)
    }
}
