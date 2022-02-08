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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getFavouriteLeagues()
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        presenter.getDataCount() == 0 ? 200 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        self.getHeaderView(width: Int(tableView.frame.width))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //presenter?.navigateToLeagueDetailsViewController(league: presenter.ge)
        let leagueDetailsViewController = Storyboards.details.instance.instantiateViewController(withIdentifier: String(describing: LeagueDetailsViewController.self)) as! LeagueDetailsViewController
        let favouriteLeague = presenter.getItemAtIndex(index: indexPath.row)
        let leagueDetailsPresenter = LeagueDetailsPresenter(LeagueDetailsView: leagueDetailsViewController, league: LeagueModel(idLeague: favouriteLeague?.idLeague, strLeague: favouriteLeague?.strLeague, strSport: "", strLeagueAlternate: "", strCurrentSeason: "", strYoutube: favouriteLeague?.strYoutube, strBadge: favouriteLeague?.strBadge))
        leagueDetailsViewController.leagueDetailsPresenter = leagueDetailsPresenter
        let navCon = UINavigationController(rootViewController: leagueDetailsViewController)
        navCon.modalPresentationStyle = .fullScreen
        navCon.isNavigationBarHidden = true
        self.present(navCon, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: " Remove League From Favourites", message: "Are you sure you want to Unfavourite this league \nchoose delete or cancel", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {action in
            let favouriteLeague = self.presenter.getItemAtIndex(index: indexPath.row)
            self.leaguesTableView.beginUpdates()
            DataManager.deleteLeague(withID: favouriteLeague?.idLeague ?? "")
            self.presenter.daleteItem(indexPath: indexPath)
            //            self.leaguesTableView.reloadData()
            self.leaguesTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            self.leaguesTableView.endUpdates()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            print("Cancel is pressed")
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - League List View delegate
extension FavouriteLeaguesViewController : FavouriteLeaguesControllerProtocol {
    func displayFavouriteLeagues(){
        self.leaguesTableView.reloadData()
    }
}
