//
//  LeaguesListViewPresenter.swift
//  SportsApp
//
//  Created by Mohamed Ahmed on 02/02/2022.
//  Copyright © 2022 admin. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Leagues list view presenter Protocol

protocol LeaguesListViewPresenterDelegate: AnyObject{
    func presentLeagues (data : [LeagueModel])
    func renderTableView()
}
// MARK: - Type aliases

typealias LeaguesListViewPresenterDelegateAlias = LeaguesListViewPresenterDelegate & UIViewController

class LeaguesListViewPresenter {
    
    // MARK: - Properties
    weak var delegate: LeaguesListViewPresenterDelegateAlias?
    
    
    // MARK: - Methods
    public func getLeagues(){
        NetworkManager().request(fromEndpoint: .allLeagues, httpMethod: .get) { [weak self](result:Result<GetAllLeaguesResponseModel, Error>) in
            switch result {
            case .success(let response):
                let leagues = response.leagues
                self?.delegate?.presentLeagues(data: leagues)
                DispatchQueue.main.async {
                    self?.delegate?.renderTableView()
                }
//                print(response.leagues.count)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func setViewDelegate (delegate : LeaguesListViewPresenterDelegateAlias){
        self.delegate=delegate
    }
    public func navigateToLeagueDetailsViewController(league: LeagueModel){
        let leagueDetailsViewController = Storyboards.details.instance.instantiateViewController(withIdentifier: String(describing: LeagueDetailsViewController.self)) as! LeagueDetailsViewController
        delegate?.navigationController?.pushViewController(leagueDetailsViewController, animated: true)
    }
}
