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
    
    // MARK: - Properties
    var data : [LeagueModel] = []
    var presenter : LeaguesListViewPresenter?
    var refreshControl:UIRefreshControl!
        
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI ()
        configureTableView()
        refreshCollectionView()
        activityIndicatorView.startAnimating()
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
    
    func refreshCollectionView(){
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing...")
        refreshControl.tintColor = UIColor.init(named: "ourPurple")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        leaguesTableView.addSubview(refreshControl)
    }
    
    @objc private func refresh(){
        presenter?.getLeagues()
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
            cell.displayLeagueName(name: data[indexPath.row].strLeague ?? "")
            cell.displayCellImage(imageUrl: data[indexPath.row].strBadge ?? "")
            cell.youtubeAction  = {[weak self] in
                self?.openLink(url: self?.data[indexPath.row].strYoutube ?? "")
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
        presenter?.navigateToLeagueDetailsViewController(league: data[indexPath.row])
    }
}

// MARK: - League List View delegate
extension LeaguesListViewController :LeaguesListViewPresenterDelegate{
    func presentLeagues(data: [LeagueModel]) {
        self.data=data.reversed()
    }
    
    func renderTableView() {
        hidePlaceHolder = false
        self.leaguesTableView.reloadData()
        activityIndicatorView.stopAnimating()
        if self.refreshControl.isRefreshing
        {
          self.refreshControl.endRefreshing()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        self.getHeaderView(width:Int(tableView.frame.width))
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        self.data.count == 0 && !hidePlaceHolder ? 200 : 0
    }
}
