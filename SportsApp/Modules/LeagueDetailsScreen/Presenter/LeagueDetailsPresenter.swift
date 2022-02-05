//
//  LeagueDetailsPresenter.swift
//  SportsApp
//
//  Created by admin on 1/28/22.
//  Copyright © 2022 admin. All rights reserved.
//
import Foundation

class LeagueDetailsPresenter :LeagueDetailsPresenterProtocol{
        
    //MARK: - Properties
    var teams : [TeamModel]?
    var upcomingEvents : [EventModel]?
    var latestResults : [EventModel]?
    
    weak var LeagueDetailsView:LeagueDetailsViewControllerProtocol!
    
    init(LeagueDetailsView:LeagueDetailsViewControllerProtocol){
        
        self.LeagueDetailsView = LeagueDetailsView
        
        getTeams()
        getUpcomingEvents()
        getLatestResults()
        
    }
    
    //MARK: - Functions
    func getUpcomingEvents() {
        NetworkManager().request(fromEndpoint: .events, httpMethod: .post,parameters: ["e":("\(LeagueDetailsView.getLeagueName())_2022-02-08")]) { [weak self](result:Result<GetAllUpComingEventsResponseModel, Error>) in
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
    
    func getUpcomingEventWithIndex(index: Int) -> EventModel {
        return self.upcomingEvents?[index] ?? EventModel()
    }
    
    func getUpcomingEventsCount() -> Int {
        return self.upcomingEvents?.count ?? 0
    }
    
    func getLatestResults() {
        NetworkManager().request(fromEndpoint: .events, httpMethod: .post,parameters: ["e":("\(LeagueDetailsView.getLeagueName())_2022-01-15")]) { [weak self](result:Result<GetAllLatestEventsResponseModel, Error>) in
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
        NetworkManager().request(fromEndpoint: .allTeams, httpMethod: .post,parameters: ["l":LeagueDetailsView.getLeagueName()]) { [weak self](result:Result<GetAllTeamsResponseModel, Error>) in
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
