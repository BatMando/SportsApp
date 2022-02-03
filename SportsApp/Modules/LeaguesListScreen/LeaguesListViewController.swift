//
//  LeaguesListViewController.swift
//  SportsApp
//
//  Created by admin on 1/28/22.
//  Copyright © 2022 admin. All rights reserved.
//

import UIKit

class LeaguesListViewController: UIViewController {
    
    
    // MARK: - IBOutlet
    @IBOutlet weak var leaguesTableView: UITableView!
    
    // MARK: - Properties
    
    var data : [LeagueModel] = []
    private let presenter = LeaguesListViewPresenter ()
//    let appearance = UINavigationBarAppearance()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Leagues"
        configureTableView()
        presenter.setViewDelegate(delegate: self)
        presenter.getLeagues()
    }
    // MARK: - Methods
    func configureTableView () {
        self.leaguesTableView.register(UINib(nibName: String(describing: LeaguesTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: LeaguesTableViewCell.self))
        self.leaguesTableView.delegate = self
        self.leaguesTableView.dataSource = self
    }
}
// MARK: - Tableview delegate and datasource
extension LeaguesListViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LeaguesTableViewCell.self), for: indexPath) as? LeaguesTableViewCell {
            cell.model = self.data[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.navigateToLeagueDetailsViewController(league: data[indexPath.row])
    }
    
}
// MARK: - League List View delegate

extension LeaguesListViewController :LeaguesListViewPresenterDelegate{
    func presentLeagues(data: [LeagueModel]) {
        self.data=data
    }
    
    func renderTableView() {
        self.leaguesTableView.reloadData()
    }
    
}

