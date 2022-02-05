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
    @IBOutlet weak var LeagueTitleLabel: UILabel!
    
    // MARK: - Properties
    var leagueName : String?
    var teams : [TeamModel]?
    var upComingEvents : [EventModel]?
    var latestEvents : [EventModel]?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCollectionViews()
        getTeams()
        getUpcomingEvents()
        getLatestEvents()
    }
    
    // MARK: - Functions
    private func configureCollectionViews(){
        registerCellsForCollectionViews()
        setupCollectionViewsDataSource()
    }
    private func configureUI () {
        self.LeagueTitleLabel.text = leagueName
    }
    func getCurrentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)

    }
    public func getTeams(){
        
        NetworkManager().request(fromEndpoint: .allTeams, httpMethod: .post,parameters: ["l":leagueName!]) { [weak self](result:Result<GetAllTeamsResponseModel, Error>) in
            switch result {
            case .success(let response):
                self?.teams = response.teams
//                self?.delegate?.presentLeagues(data: leagues)
                DispatchQueue.main.async {
//                    self?.delegate?.renderTableView()
                    self?.teamsCollectionView.reloadData()
                }
//                print(response.leagues.count)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    public func getUpcomingEvents(){
//        ["e":("\(leagueName!)_\(getCurrentDate())")]
        NetworkManager().request(fromEndpoint: .events, httpMethod: .post,parameters: ["e":("\(leagueName!)_2022-02-08")]) { [weak self](result:Result<GetAllUpComingEventsResponseModel, Error>) in
            switch result {
            case .success(let response):
                self?.upComingEvents = response.event
//                self?.delegate?.presentLeagues(data: leagues)
                DispatchQueue.main.async {
//                    self?.delegate?.renderTableView()
                    self?.upcomingEventsCollectionView.reloadData()
                }
//                print(response.leagues.count)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    public func getLatestEvents(){
//        ["e":("\(leagueName!)_\(getCurrentDate())")]
        NetworkManager().request(fromEndpoint: .events, httpMethod: .post,parameters: ["e":("\(leagueName!)_2022-01-15")]) { [weak self](result:Result<GetAllLatestEventsResponseModel, Error>) in
            switch result {
            case .success(let response):
                self?.latestEvents = response.event
//                self?.delegate?.presentLeagues(data: leagues)
                DispatchQueue.main.async {
//                    self?.delegate?.renderTableView()
                    self?.latestEventsTableView.reloadData()
                }
//                print(response.leagues.count)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
    // MARK: - IBActions
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func favouriteButtonPressed(_ sender: UIButton) {
        print("favourites button pressed")
    }
}
// MARK: - extension UITableViewDataSource
extension LeagueDetailsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return latestEvents?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LatestEventTableViewCell.self), for: indexPath) as! LatestEventTableViewCell
        let latestEvent = latestEvents? [indexPath.row]
        cell.displayEventThumbnail(imageUrl: latestEvent?.strThumb ?? "")
        cell.displayEventTime(time: latestEvent?.strTime ?? "")
        cell.displayEventDate(date: latestEvent?.dateEvent ?? "")
        cell.displayEventStatus(status: latestEvent?.strStatus ?? "")
        cell.displayEventResult(result: "\(latestEvent?.intHomeScore ?? " ") - \(latestEvent?.intAwayScore ?? " ")")
        cell.displayHomeTeamName(name: latestEvent?.strHomeTeam ?? "")
        cell.displayAwayTeamName(name: latestEvent?.strAwayTeam ?? "")
        
        print(latestEvent?.strThumb ?? "")
        return cell
    }
}

// MARK: - extension UITableViewDelegate
extension LeagueDetailsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (latestEventsTableView.frame.width * 9 ) / 16
    }
}

// MARK: - extension UICollectionViewDataSource
extension LeagueDetailsViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == teamsCollectionView {
            return teams?.count ?? 0
        }else {
            return upComingEvents?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == teamsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TeamCollectionViewCell.self), for: indexPath) as! TeamCollectionViewCell
            let team = teams? [indexPath.row]
            cell.displayTeamName(name: team?.strTeam ?? "")
            cell.displayTeamLogo(imageUrl: team?.strTeamBadge ?? "")
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UpcomingEventCollectionViewCell.self), for: indexPath) as! UpcomingEventCollectionViewCell
            let upComingEvent = upComingEvents? [indexPath.row]
            cell.displayEventDate(date: upComingEvent?.dateEvent ?? "")
            cell.displayEventTime(time: upComingEvent?.strTime ?? "")
            cell.displayEventThumbnail(imageUrl: upComingEvent?.strThumb ?? "")
            cell.displayHomeTeamName(name: upComingEvent?.strHomeTeam ?? "")
            cell.displayAwayTeamName(name: upComingEvent?.strAwayTeam ?? "")
    
            return cell
        }
    }
    
    
    
}
// MARK: - extension UICollectionViewDelegate
extension LeagueDetailsViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard collectionView == teamsCollectionView else {return}

        let teamDetailsViewController = Storyboards.details.instance.instantiateViewController(withIdentifier: String(describing: TeamDetailsViewController.self)) as! TeamDetailsViewController
        
        self.navigationController?.pushViewController(teamDetailsViewController, animated: true)
    }
    
}
// MARK: - extension UICollectionViewDelegateFlowLayout

extension LeagueDetailsViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == teamsCollectionView {
            return CGSize(width: 160, height: teamsCollectionView.bounds.height)
        }else{
            return CGSize(width: self.view.bounds.width - 16 , height: upcomingEventsCollectionView.bounds.height)
//          (latestEventsTableView.frame.width * 9 ) / 16
        }
    }
}
