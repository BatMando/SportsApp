//
//  FavouriteLeaguesViewController.swift
//  SportsApp
//
//  Created by admin on 1/28/22.
//  Copyright © 2022 admin. All rights reserved.
//

import UIKit

class FavouriteLeaguesViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tabBarController?.tabBar
   
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("appeared")
        self.tabBarController?.tabBar.tintColor = UIColor.white // tab bar icon tint color
        self.tabBarController?.tabBar.isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor(named: "bottomNavigation")
//        UITabBar.appearance().barTintColor = UIColor.red

    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
