//
//  FavouriteLeaguesViewController.swift
//  SportsApp
//
//  Created by admin on 1/28/22.
//  Copyright © 2022 admin. All rights reserved.
//

import UIKit

class FavouriteLeaguesViewController: BaseViewController {

    // MARK: - IBOutlet
@IBOutlet weak var leaguesTableView: UITableView!
    // MARK: - Properties
    var presenter : FavouriteLeaguesPresenterProtocol!

    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FavouriteLeaguesPresenter(view: self)

        configureTableView()
       // presenter?.setViewDelegate(delegate: self)
       // presenter?.getLeagues()
    }
      // MARK: - Methods
    func configureTableView () {
         self.leaguesTableView.register(UINib(nibName: String(describing: LeaguesTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: LeaguesTableViewCell.self))
         self.leaguesTableView.delegate = self
         self.leaguesTableView.dataSource = self
     }
    // MARK: - IBActions

}
// MARK: - Tableview delegate and datasource
extension FavouriteLeaguesViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getDataCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LeaguesTableViewCell.self), for: indexPath) as? LeaguesTableViewCell {
            if let league = presenter?.getItemAtIndex(index: indexPath.row) {
                cell.displayLeagueName(name: league.strLeague ?? "")
                cell.displayCellImage(imageUrl: league.strBadge ?? "")
            }
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  presenter?.navigateToLeagueDetailsViewController(league: presenter.get)
    }
    
}
// MARK: - League List View delegate
extension FavouriteLeaguesViewController : FavouriteLeaguesControllerProtocol {
    func displayFavouriteLeagues(){
        
        self.leaguesTableView.reloadData()
        
    }
}
