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
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        NetworkManager().request(fromEndpoint: .allLeagues, httpMethod: .get) { (result:Result<GetAllLeaguesResponseModel, Error>) in
              switch result {
              case .success(let response):
                  self.data = response.leagues
                  self.leaguesTableView.reloadData()
                  print(response.leagues.count)
              case .failure(let error):
                  print(error.localizedDescription)
              }
          }
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
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        let leagueDetailsViewController = storyboard.instantiateViewController(withIdentifier: String(describing: LeagueDetailsViewController.self)) as! LeagueDetailsViewController
        self.navigationController?.pushViewController(leagueDetailsViewController, animated: true)
    }
    
}
