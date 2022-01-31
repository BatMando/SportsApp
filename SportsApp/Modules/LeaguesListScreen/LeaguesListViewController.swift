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
    
    let data = ["egyption league","egyption league","egyption league","mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm"]
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    // MARK: - Methods
    func configureTableView () {
        self.leaguesTableView.register(UINib(nibName: "LeaguesTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LeaguesTableViewCell {
            cell.leagueName.text = self.data[indexPath.row]
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
