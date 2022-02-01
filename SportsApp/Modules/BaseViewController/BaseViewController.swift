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
        
    }
    
    
    func navigateToLeaguesViewController(withSportId : Int){
        let leaguesViewController = Storyboards.details.instance.instantiateViewController(withIdentifier: String(describing: LeaguesListViewController.self)) as! LeaguesListViewController
        self.navigationController?.pushViewController(leaguesViewController, animated: true)
    }
    
}
