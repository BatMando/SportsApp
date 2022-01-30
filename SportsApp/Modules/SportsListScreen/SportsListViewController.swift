//
//  ViewController.swift
//  SportsApp
//
//  Created by admin on 1/28/22.
//  Copyright © 2022 admin. All rights reserved.
//

import UIKit

class SportsListViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var sportsCollectionView: UICollectionView!
    
    
    //MARK: - Properties
    var showStyle:Bool?
    let sportsCellID = "sportsCell"
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibCollectionViewCell = UINib(nibName: "SportsCollectionViewCell", bundle: nil)
        	
        sportsCollectionView.register(nibCollectionViewCell, forCellWithReuseIdentifier: sportsCellID)
    }

    //MARK: - Methodes
    
    
    //MARK: - IBActions
    @IBAction func styleBtn(_ sender: Any) {
    }
    

}

extension SportsListViewController: UICollectionViewDelegate{
    
}

extension SportsListViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sportsCVCell = sportsCollectionView.dequeueReusableCell(withReuseIdentifier: sportsCellID, for: indexPath) as! SportsCollectionViewCell
        
        sportsCVCell.layoutIfNeeded()
        sportsCVCell.sportImage.layer.cornerRadius = sportsCVCell.sportImage.frame.height/6
        sportsCVCell.bgView.layer.cornerRadius = sportsCVCell.bgView.frame.height/6

        
        return sportsCVCell
    }
    
}

extension SportsListViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: (UIScreen.main.bounds.width/2)-20, height: (UIScreen.main.bounds.height/4)-20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

