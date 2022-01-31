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
    var isGridActive = false
    let sportsCellID = "sportsCell"
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        
    }
    
    //MARK: - Methodes
    private func configureCollectionView(){
        let nibCollectionViewCell = UINib(nibName: "SportsCollectionViewCell", bundle: nil)
        sportsCollectionView.register(nibCollectionViewCell, forCellWithReuseIdentifier: sportsCellID)
    }
    
    //MARK: - IBActions
    @IBAction func styleBtn(_ sender: Any) {
        isGridActive = !isGridActive
        self.sportsCollectionView.reloadData()
    }
    
    
}
//MARK: - UICollectionViewDelegate
extension SportsListViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        let leaguesViewController = storyboard.instantiateViewController(withIdentifier: String(describing: LeaguesListViewController.self)) as! LeaguesListViewController
        self.navigationController?.pushViewController(leaguesViewController, animated: true)
    }
    
}

//MARK: - UICollectionViewDataSource
extension SportsListViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sportsCVCell = sportsCollectionView.dequeueReusableCell(withReuseIdentifier: sportsCellID, for: indexPath) as! SportsCollectionViewCell
                return sportsCVCell
    }
    
}

extension SportsListViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = isGridActive ? CGSize(width: (self.sportsCollectionView.frame.width - 16) / 2, height: (self.sportsCollectionView.frame.width) / 2 ): CGSize(width: sportsCollectionView.frame.width , height:140)
        
        return size
    }
}

