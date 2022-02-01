//
//  ViewController.swift
//  SportsApp
//
//  Created by admin on 1/28/22.
//  Copyright © 2022 admin. All rights reserved.
//

import UIKit

class SportsListViewController: BaseViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var sportsCollectionView: UICollectionView!
    
    
    //MARK: - Properties
    var isGridActive = false
    var sports : [SportModel] = []
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        NetworkManager().request(fromEndpoint: .allSports, httpMethod: .get) { (result:Result<GetAllSportsResponseModel, Error>) in
            switch result {
            case .success(let response):
                self.sports = response.sports ?? []
                self.sportsCollectionView.reloadData()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    //MARK: - Methodes
    private func configureCollectionView(){
        let nibCollectionViewCell = UINib(nibName: String(describing: SportsCollectionViewCell.self), bundle: nil)
        sportsCollectionView.register(nibCollectionViewCell, forCellWithReuseIdentifier: String(describing: SportsCollectionViewCell.self))
        sportsCollectionView.dataSource = self
        sportsCollectionView.delegate = self
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
       navigateToLeaguesViewController(withSportId: 0)
    }
}

//MARK: - UICollectionViewDataSource
extension SportsListViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sportsCVCell = sportsCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SportsCollectionViewCell.self), for: indexPath) as! SportsCollectionViewCell
        sportsCVCell.model = sports[indexPath.row]
        //populate cell
                return sportsCVCell
    }
}

extension SportsListViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = isGridActive ? CGSize(width: (self.sportsCollectionView.frame.width - 16) / 2, height: (self.sportsCollectionView.frame.width - 16) / 2 ): CGSize(width: sportsCollectionView.frame.width , height:140)
        return size
    }
}

