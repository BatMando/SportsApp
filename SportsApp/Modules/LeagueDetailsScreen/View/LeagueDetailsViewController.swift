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
    
    @IBOutlet weak var favouriteBtn: UIButton!
    // MARK: - Properties
    var leagueDetailsPresenter : LeagueDetailsPresenterProtocol!
    var favouriteStatus = false
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCollectionViews()
    }
    
    // MARK: - Functions
    private func configureUI () {
        self.LeagueTitleLabel.text = leagueDetailsPresenter.getLeagueName()
        changeFavouriteState()
    }
    private func changeFavouriteState(){
        self.favouriteStatus = leagueDetailsPresenter.checkIsFavourite()
        favouriteBtn.setImage(self.favouriteStatus ? #imageLiteral(resourceName: "fav_ic_filled"):#imageLiteral(resourceName: "fav_ic_unfilled"), for: .normal)
    }
    
    private func configureCollectionViews(){
        registerCellsForCollectionViews()
        setupCollectionViewsDataSource()
    }
    
    func getCurrentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)

    }
    /*public func getTeams(){
        
        
    }
    public func getUpcomingEvents(){
//        ["e":("\(leagueName!)_\(getCurrentDate())")]
        
    }
    public func getLatestEvents(){
//        ["e":("\(leagueName!)_\(getCurrentDate())")]
        
    }*/
    
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
        if favouriteStatus {
            leagueDetailsPresenter.removeFromFavourites(id: leagueDetailsPresenter.getLeaugeID())
            changeFavouriteState()
        }
        else{
            leagueDetailsPresenter.addLeagueToFavourite()
            changeFavouriteState()
        }
        
    }
}
// MARK: - extension UITableViewDataSource
extension LeagueDetailsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagueDetailsPresenter.getLatestResultsCount()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LatestEventTableViewCell.self), for: indexPath) as! LatestEventTableViewCell
        
        let latestEvent = leagueDetailsPresenter.getLatestResultWithIndex(index: indexPath.row)
        
        cell.displayEventThumbnail(imageUrl: latestEvent.strThumb ?? "")
        cell.displayEventTime(time: latestEvent.strTime ?? "")
        cell.displayEventDate(date: latestEvent.dateEvent ?? "")
        cell.displayEventStatus(status: latestEvent.strStatus ?? "")
        cell.displayEventResult(result: "\(latestEvent.intHomeScore ?? " ") - \(latestEvent.intAwayScore ?? " ")")
        cell.displayHomeTeamName(name: latestEvent.strHomeTeam ?? "")
        cell.displayAwayTeamName(name: latestEvent.strAwayTeam ?? "")
        
        print(latestEvent.strThumb ?? "")
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
            return leagueDetailsPresenter.getTeamsCount()
        }else {
            return leagueDetailsPresenter.getUpcomingEventsCount()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == teamsCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TeamCollectionViewCell.self), for: indexPath) as! TeamCollectionViewCell
            
            let team = leagueDetailsPresenter.getTeamWithIndex(index: indexPath.row)
            
            cell.displayTeamName(name: team.strTeam ?? "")
            cell.displayTeamLogo(imageUrl: team.strTeamBadge ?? "")
            
            return cell
            
        }else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UpcomingEventCollectionViewCell.self), for: indexPath) as! UpcomingEventCollectionViewCell
            
            let upComingEvent = leagueDetailsPresenter.getUpcomingEventWithIndex(index: indexPath.row)
            
            cell.displayEventDate(date: upComingEvent.dateEvent ?? "")
            cell.displayEventTime(time: upComingEvent.strTime ?? "")
            cell.displayEventThumbnail(imageUrl: upComingEvent.strThumb ?? "")
            cell.displayHomeTeamName(name: upComingEvent.strHomeTeam ?? "")
            cell.displayAwayTeamName(name: upComingEvent.strAwayTeam ?? "")
    
            return cell
        }
    }
    
}
// MARK: - extension UICollectionViewDelegate
extension LeagueDetailsViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard collectionView == teamsCollectionView else {return}

        let teamDetailsViewController = Storyboards.details.instance.instantiateViewController(withIdentifier: String(describing: TeamDetailsViewController.self)) as! TeamDetailsViewController
        
        let teamDetailsPresenter = TeamDetailsPresenter(view: teamDetailsViewController as TeamDetailsViewControllerProtocol , teamModel: leagueDetailsPresenter.getTeamWithIndex(index: indexPath.row))
       teamDetailsViewController.teamDetailsPresenter = teamDetailsPresenter
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

extension LeagueDetailsViewController : LeagueDetailsViewControllerProtocol{
    
    
    func didRemoveFromFavouriteSuccessfully() {
        //update UI To gray
    }
    
    func didAddedToFavouriteSuccessfully() {
        //update UI To Red
    }
    
  
    
    func reloadUpcomingEventsCollectionView() {
        self.upcomingEventsCollectionView.reloadData()
    }
    
    func reloadLatestResultsTableView() {
        self.latestEventsTableView.reloadData()
    }
    
    func reloadTeamsCollectionView() {
        self.teamsCollectionView.reloadData()
    }
}
