//
//  BaseViewController.swift
//  SportsApp
//
//  Created by admin on 1/31/22.
//  Copyright © 2022 admin. All rights reserved.
//

import UIKit
import Network

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(displayNetworkAlert), name: Notification.Name.init(rawValue: "NotInternetConnection"), object: nil)
    }
   @objc func displayNetworkAlert(){
        let noNetworkVC = Storyboards.main.instance.instantiateViewController(withIdentifier: "NoInternetConnectionViewController") as! NoInternetConnectionViewController
        noNetworkVC.modalPresentationStyle = .currentContext
        self.present(noNetworkVC, animated: true, completion: nil)
    }
    func navigateToLeaguesViewController(withSportName : String){
        let leaguesViewController = Storyboards.details.instance.instantiateViewController(withIdentifier: String(describing: LeaguesListViewController.self)) as! LeaguesListViewController
        leaguesViewController.presenter = LeaguesListViewPresenter(sportName: withSportName)
        let navCon = UINavigationController (rootViewController: leaguesViewController)
        navCon.modalPresentationStyle = .fullScreen
        navCon.isNavigationBarHidden = true
        self.present(navCon, animated: true, completion: nil)
        //        self.navigationController?.pushViewController(navCon, animated: true)
    }
    
}
