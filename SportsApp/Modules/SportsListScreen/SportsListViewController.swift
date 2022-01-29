//
//  ViewController.swift
//  SportsApp
//
//  Created by admin on 1/28/22.
//  Copyright © 2022 admin. All rights reserved.
//

import UIKit
// to be con
class SportsListViewController: UIViewController {

    @IBOutlet weak var sportsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let nibCollectionViewCell = UINib(nibName: "SportsCollectionViewCell", bundle: nil)
        sportsCollectionView.register(nibCollectionViewCell, forCellWithReuseIdentifier: "sportsCell")
    }


}

extension SportsListViewController: UICollectionViewDelegate{
    
}

extension SportsListViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sportsCell = sportsCollectionView.dequeueReusableCell(withReuseIdentifier: "sportsCell", for: <#T##IndexPath#>) as! SportsCollectionViewCell
        
        return sportsCell
    }
    
}

