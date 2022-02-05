//
//  BaseViewController.swift
//  SportsApp
//
//  Created by admin on 1/31/22.
//  Copyright © 2022 admin. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
//        self.navigationController?.navigationBar.tintColor = UIColor.white
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.barStyle = .black

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
