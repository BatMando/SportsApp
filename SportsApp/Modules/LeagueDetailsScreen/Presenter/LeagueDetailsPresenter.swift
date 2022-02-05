//
//  LeagueDetailsPresenter.swift
//  SportsApp
//
//  Created by admin on 1/28/22.
//  Copyright © 2022 admin. All rights reserved.
//
import Foundation
import CoreData
class LeagueDetailsPresenter :LeagueDetailsPresenterProtocol{
    
    
    
    
    
    //MARK: - Properties
    var league: LeagueModel
    var teams : [TeamModel]?
    var upcomingEvents : [EventModel]?
    var latestResults : [EventModel]?
    
    weak var LeagueDetailsView:LeagueDetailsViewControllerProtocol!
    
    init(LeagueDetailsView:LeagueDetailsViewControllerProtocol, league : LeagueModel){
        
        self.LeagueDetailsView = LeagueDetailsView
        self.league = league
        getTeams()
        getUpcomingEvents()
        getLatestResults()
        
    }
    
    //MARK: - Functions
    func getLeagueName() -> String {
        return league.strLeague ?? ""
    }
    
    
    
    func getUpcomingEvents() {
        guard let leagueName = league.strLeague else {
            return
        }
        NetworkManager().request(fromEndpoint: .events, httpMethod: .post,parameters: ["e":("\(leagueName)_2022-02-08")]) { [weak self](result:Result<GetAllUpComingEventsResponseModel, Error>) in
            switch result {
            case .success(let response):
                self?.upcomingEvents = response.event
                //              self?.delegate?.presentLeagues(data: leagues)
                DispatchQueue.main.async {
                    //                  self?.delegate?.renderTableView()
                    self?.LeagueDetailsView.reloadUpcomingEventsCollectionView()
                }
            //              print(response.leagues.count)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func addLeagueToFavourite() {
        guard let entity = NSEntityDescription.entity(forEntityName: "FavouriteLeagueModel", in: DataManager.context) else {
            fatalError("Failed to decode User")
        }
        let newleague = FavouriteLeagueModel(entity: entity, insertInto: DataManager.context)
        newleague.idLeague = league.idLeague
        newleague.strLeague = league.strLeague
        newleague.strBadge = league.strBadge
        newleague.strYoutube = league.strYoutube
        DataManager.saveContext()
        LeagueDetailsView.didAddedToFavouriteSuccessfully()
        
    }
    
    func getUpcomingEventWithIndex(index: Int) -> EventModel {
        return self.upcomingEvents?[index] ?? EventModel()
    }
    
    func getUpcomingEventsCount() -> Int {
        return self.upcomingEvents?.count ?? 0
    }
    
    func getLatestResults() {
        guard let leagueName = league.strLeague else {
            return
        }
        NetworkManager().request(fromEndpoint: .events, httpMethod: .post,parameters: ["e":("\(leagueName)_2022-01-15")]) { [weak self](result:Result<GetAllLatestEventsResponseModel, Error>) in
            switch result {
            case .success(let response):
                self?.latestResults = response.event
                //              self?.delegate?.presentLeagues(data: leagues)
                DispatchQueue.main.async {
                    //                  self?.delegate?.renderTableView()
                    self?.LeagueDetailsView.reloadLatestResultsTableView()
                }
            //print(self?.latestResults?.count)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getLatestResultWithIndex(index: Int) -> EventModel {
        return self.latestResults?[index] ?? EventModel()
    }
    
    func getLatestResultsCount() -> Int {
        return self.latestResults?.count ?? 0
    }
    
    func getTeams() {
        guard let leagueName = league.strLeague else {
            return
        }
        NetworkManager().request(fromEndpoint: .allTeams, httpMethod: .post,parameters: ["l":leagueName]) { [weak self](result:Result<GetAllTeamsResponseModel, Error>) in
            switch result {
                
            case .success(let response):
                self?.teams = response.teams
                //self?.delegate?.presentLeagues(data: leagues)
                DispatchQueue.main.async {
                    //self?.delegate?.renderTableView()
                    self?.LeagueDetailsView.reloadTeamsCollectionView()
                }
            //print("******\(self?.teams?.count)")
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    func getTeamWithIndex(index: Int) -> TeamModel {
        return self.teams?[index] ?? TeamModel()
    }
    
    func getTeamsCount() -> Int {
        return self.teams?.count ?? 0
    }
    
}
