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
    @IBOutlet weak var styleButton: UIButton!
    
    
    //MARK: - Properties
    var isGridActive = false
    var presenter : SportsPresenter?
    var refreshControl:UIRefreshControl!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        refreshCollectionView()
        presenter = SportsListPresenter(view: self)
    }
    
    //MARK: - Methodes
    private func configureCollectionView(){
        let nibCollectionViewCell = UINib(nibName: String(describing: SportsCollectionViewCell.self), bundle: nil)
        sportsCollectionView.register(nibCollectionViewCell, forCellWithReuseIdentifier: String(describing: SportsCollectionViewCell.self))
        sportsCollectionView.dataSource = self
        sportsCollectionView.delegate = self
    }
    
   private func refreshCollectionView(){
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing...")
        refreshControl.tintColor = UIColor.init(named: "ourPurple")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        sportsCollectionView.addSubview(refreshControl)
    }
    
    @objc private func refresh(){
        presenter?.getSports()
    }
    //MARK: - IBActions
    @IBAction func styleBtn(_ sender: Any) {
        isGridActive = !isGridActive
        styleButton.setImage(isGridActive ? #imageLiteral(resourceName: "listview_ic"):#imageLiteral(resourceName: "gridview_ic"), for: .normal)
        self.sportsCollectionView.reloadData()
    }
}
//MARK: - UICollectionViewDelegate
extension SportsListViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToLeaguesViewController(withSportName: presenter?.getSport(atIndex: indexPath).strSport ?? " ")
    }
}
//MARK: - UICollectionViewDataSource
extension SportsListViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = presenter?.getSportsCount() ?? 0
        self.sportsCollectionView.backgroundView = count == 0 ? self.getHeaderView(width: Int(sportsCollectionView.bounds.width)):nil
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sportsCVCell = sportsCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SportsCollectionViewCell.self), for: indexPath) as! SportsCollectionViewCell
        let sport = presenter?.getSport(atIndex: indexPath)
        sportsCVCell.displaySportName(name: sport?.strSport ?? "")
        sportsCVCell.displayCellImage(imageUrl: sport?.strSportThumb ?? "")
        return sportsCVCell
    }
}

extension SportsListViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = isGridActive ? CGSize(width: (self.sportsCollectionView.frame.width - 16) / 2, height: (self.sportsCollectionView.frame.width - 16) / 2 ): CGSize(width: sportsCollectionView.frame.width , height:140)
        return size
    }
}

extension SportsListViewController : presenterToViewDelegate {
    
    func reloadDataInCollectionView() {
        self.sportsCollectionView.reloadData()
        if self.refreshControl.isRefreshing
        {
          self.refreshControl.endRefreshing()
        }
    }
}
