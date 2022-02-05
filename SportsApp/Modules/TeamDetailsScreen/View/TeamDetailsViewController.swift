//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by admin on 1/28/22.
//  Copyright © 2022 admin. All rights reserved.
//

import UIKit
import Kingfisher

class TeamDetailsViewController: UIViewController ,TeamDetailsViewControllerProtocol{
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
        self.teamLogoImageView.kf.setImage(with: URL(string: team.strTeamBadge ?? "" ))
        self.teamGersyImageView.kf.setImage(with: URL(string: team.strTeamJersey ?? ""))
        self.stadiumImageView.kf.setImage(with: URL(string: team.strStadiumThumb ?? "" ))
    }
    func openLink(url : String?){
        guard let officialWebSite = url else{return}

             guard let appURL = URL(string:"https://\(officialWebSite)") else {return}
             if UIApplication.shared.canOpenURL(appURL as URL) {
                      if #available(iOS 10.0, *) {
                          UIApplication.shared.open(appURL as URL, options:
                      [:], completionHandler: nil)
                      }
                      else { UIApplication.shared.openURL(appURL as URL)
                      }
                  }
             else {
                      //redirect to safari because the user doesn't have
                       // Instagram
                      if #available(iOS 10.0, *) {
                          UIApplication.shared.open(appURL as URL, options:
                          [:], completionHandler: nil)
                      }
                      else {UIApplication.shared.openURL(appURL as URL)
                      }
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
