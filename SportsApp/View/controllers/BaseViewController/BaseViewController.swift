//
//  BaseViewController.swift
//  SportsApp
//
//  Created by admin on 1/31/22.
//  Copyright © 2022 admin. All rights reserved.
//

import UIKit
import Network
import Toaster
import NVActivityIndicatorView

class BaseViewController: UIViewController {
    
    var activityIndicatorView : NVActivityIndicatorView!
    var hidePlaceHolder = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = CGRect(x: (self.view.frame.width-50)/2, y: (self.view.frame.height-50)/2, width: 50, height: 50)

        activityIndicatorView = NVActivityIndicatorView (frame:frame, type: .ballScaleRippleMultiple, color: UIColor.init(named: "ourPurple"), padding: nil)
        self.view.addSubview(activityIndicatorView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(displayNetworkAlert), name: Notification.Name.init(rawValue: "NotInternetConnection"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(hideNetworkAlert), name: Notification.Name.init(rawValue: "ConnectedToNetwork"), object: nil)
        
    }
    
    @objc func hideNetworkAlert(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func displayNetworkAlert(){
        
        
        
        
        
        
        let noNetworkVC = Storyboards.main.instance.instantiateViewController(withIdentifier: "NoInternetConnectionViewController") as! NoInternetConnectionViewController
        if #available(iOS 13.0, *) {
            if var topController = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController  {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                topController.present(noNetworkVC, animated: true, completion: nil)
            }
        }
        
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
    
    func getHeaderView(width : Int)->UIView{
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: width, height: 110))
               let imageView = UIImageView()
               let image = #imageLiteral(resourceName: "NoDataPlaceHolder")
               imageView.contentMode = .scaleAspectFill
               imageView.image = image
               imageView.frame = CGRect.init(x: 5, y: 50, width: width, height: 110)
               headerView.addSubview(imageView)
               return headerView
    }
    
    
    func openLink(url : String?){
        guard let officialWebSite = url,!url!.isEmpty else{
            let toast = Toast(text: "no link available! ", duration: Delay.short)
            toast.show()
            return
        }
        
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
    
    
    
}
