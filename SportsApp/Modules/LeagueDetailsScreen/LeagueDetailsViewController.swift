//
//  LeagueDetailsViewController.swift
//  SportsApp
//
//  Created by admin on 1/28/22.
//  Copyright © 2022 admin. All rights reserved.
//

import UIKit

class LeagueDetailsViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    @IBOutlet weak var latestEventsTableView: SelfSizedTableView!
    @IBOutlet weak var upcomingEventsCollectionView: UICollectionView!
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionViews()
        
    }
    
    // MARK: - Functions
    private func configureCollectionViews(){
        registerCellsForCollectionViews()
        setupCollectionViewsDataSource()
    }
    
    private func setupCollectionViewsDataSource(){
        teamsCollectionView.dataSource          = self
        teamsCollectionView.delegate            = self
        latestEventsTableView.dataSource        = self
        latestEventsTableView.delegate          = self
        upcomingEventsCollectionView.dataSource = self
        upcomingEventsCollectionView.delegate   = self
    }
    
    private func registerCellsForCollectionViews(){
        let upcomingNib = UINib(nibName: String(describing: UpcomingEventCollectionViewCell.self), bundle: nil)
        upcomingEventsCollectionView.register(upcomingNib, forCellWithReuseIdentifier: String(describing: UpcomingEventCollectionViewCell.self) )
        
        let latestEventNib = UINib(nibName: String(describing: LatestEventTableViewCell.self), bundle: nil)
        latestEventsTableView.register(latestEventNib, forCellReuseIdentifier: String(describing: LatestEventTableViewCell.self))
        
        let teamNib = UINib(nibName: String(describing: TeamCollectionViewCell.self), bundle: nil)
        teamsCollectionView.register(teamNib, forCellWithReuseIdentifier: String(describing: TeamCollectionViewCell.self) )
    }
    
}
// MARK: - extension UITableViewDataSource
extension LeagueDetailsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LatestEventTableViewCell.self), for: indexPath) as! LatestEventTableViewCell
        return cell
    }
}

// MARK: - extension UITableViewDelegate
extension LeagueDetailsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

// MARK: - extension UICollectionViewDataSource
extension LeagueDetailsViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == teamsCollectionView {
            return 10
        }else {
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == teamsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TeamCollectionViewCell.self), for: indexPath) as! TeamCollectionViewCell
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UpcomingEventCollectionViewCell.self), for: indexPath) as! UpcomingEventCollectionViewCell
            return cell
        }
    }
    
    
    
}
// MARK: - extension UICollectionViewDelegate
extension LeagueDetailsViewController : UICollectionViewDelegate{
    
    
}
// MARK: - extension UICollectionViewDelegateFlowLayout

extension LeagueDetailsViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == teamsCollectionView {
            return CGSize(width: 160, height: teamsCollectionView.bounds.height)
        }else{
            return CGSize(width: self.view.bounds.width - 16 , height: upcomingEventsCollectionView.bounds.height)
        }
    }
}
