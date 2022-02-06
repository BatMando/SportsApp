//
//  LeaguesListViewController.swift
//  SportsApp
//
//  Created by admin on 1/28/22.
//  Copyright © 2022 admin. All rights reserved.
//

import UIKit

class LeaguesListViewController: BaseViewController {
    
    
    // MARK: - IBOutlet
    @IBOutlet weak var leaguesTableView: UITableView!
    @IBOutlet weak var sportTilteLabel: UILabel!
    
    
    var data : [LeagueModel] = []
    var presenter : LeaguesListViewPresenter?
//    let appearance = UINavigationBarAppearance()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI ()
        configureTableView()
        presenter?.setViewDelegate(delegate: self)
        presenter?.getLeagues()
    }
    // MARK: - Methods
    private  func configureUI(){
        self.sportTilteLabel.text = presenter?.sportName
    }
    func configureTableView () {
        self.leaguesTableView.register(UINib(nibName: String(describing: LeaguesTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: LeaguesTableViewCell.self))
        self.leaguesTableView.delegate = self
        self.leaguesTableView.dataSource = self
    }
    // MARK: - IBActions
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.navigateToLeagueDetailsViewController(league: data[indexPath.row])
    }
    
}
// MARK: - League List View delegate

extension LeaguesListViewController :LeaguesListViewPresenterDelegate{
    func presentLeagues(data: [LeagueModel]) {
        self.data=data.reversed()
        
    }
    
    func renderTableView() {
        self.leaguesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        self.getHeaderView(width:Int(tableView.frame.width))
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        self.data.count == 0 ? 200 : 0
    }
    
}

