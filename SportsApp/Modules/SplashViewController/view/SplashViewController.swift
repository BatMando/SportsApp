//
//  SplashViewController.swift
//  SportsApp
//
//  Created by Mohamed Ahmed on 08/02/2022.
//  Copyright © 2022 admin. All rights reserved.
//

import UIKit
import Lottie
class SplashViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var animationVC: UIView!
    
    //MARK: - Properties
    private var animationView: AnimationView?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        playSplashAnimation()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    //MARK: - Functions
    private func playSplashAnimation(){
        animationView = .init(name: "splash-background")
        animationView!.frame = animationVC.bounds
        animationView!.contentMode = .scaleAspectFill
        animationView!.loopMode = .repeat(0)
        animationView!.animationSpeed = 2
        animationVC.addSubview(animationView!)
        animationView!.play{[weak self](finished) in
            let tabViewController = Storyboards.main.instance.instantiateViewController(withIdentifier: String(describing: TabBarViewController.self)) as! TabBarViewController
            let navCon = UINavigationController (rootViewController: tabViewController)
            navCon.modalPresentationStyle = .fullScreen
            navCon.isNavigationBarHidden = true
            self?.present(navCon, animated: true, completion: nil)
        }
    }
}
