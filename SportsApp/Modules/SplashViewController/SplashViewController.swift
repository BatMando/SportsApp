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

    @IBOutlet weak var animationVC: UIView!
    private var animationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        animationView = .init(name: "splash-background")
         
         animationView!.frame = animationVC.bounds
         
         // 3. Set animation content mode
         
        animationView!.contentMode = .scaleAspectFill
         
         // 4. Set animation loop mode
        animationView!.loopMode = .repeat(0)
         
         
         // 5. Adjust animation speed
         
        animationView!.animationSpeed = 2
         
        animationVC.addSubview(animationView!)
         
         // 6. Play animation
         
         animationView!.play{(finished) in
//             self.animationView!.isHidden = true
             let tabViewController = Storyboards.main.instance.instantiateViewController(withIdentifier: String(describing: TabBarViewController.self)) as! TabBarViewController
             let navCon = UINavigationController (rootViewController: tabViewController)
             navCon.modalPresentationStyle = .fullScreen
             navCon.isNavigationBarHidden = true
             self.present(navCon, animated: true, completion: nil)
             
         }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.update(backroundColor: .blue, titleColor: .white)
         
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
extension UINavigationBar {
  func update(backroundColor: UIColor? = nil, titleColor: UIColor? = nil) {
    if #available(iOS 15, *) {
      let appearance = UINavigationBarAppearance()
      appearance.configureWithOpaqueBackground()
      if let backroundColor = backroundColor {
        appearance.backgroundColor = backroundColor
      }
      if let titleColor = titleColor {
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
      }
      standardAppearance = appearance
      scrollEdgeAppearance = appearance
    } else {
      barStyle = .blackTranslucent
      if let backroundColor = backroundColor {
        barTintColor = backroundColor
      }
      if let titleColor = titleColor {
        titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
      }
    }
  }
}
