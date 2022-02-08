//
//  LeaguesListViewPresenter.swift
//  SportsApp
//
//  Created by Mohamed Ahmed on 02/02/2022.
//  Copyright © 2022 admin. All rights reserved.
//

import Foundation
import UIKit
// MARK: - Type aliases
typealias LeaguesListViewPresenterDelegateAlias = LeaguesListViewPresenterDelegate & UIViewController

class LeaguesListViewPresenter {
    
    // MARK: - Properties
    weak var delegate: LeaguesListViewPresenterDelegateAlias?
    var sportName : String
    
    // MARK: - Life Cycle
    init (sportName : String){
        self.sportName = sportName
    }
    
    // MARK: - Methods
    func getLeagues(){
        NetworkManager().request(fromEndpoint: .allLeagues, httpMethod: .post,parameters: ["s":sportName,"c":"England"]) {
            [weak self] (result:Result<GetAllLeaguesResponseModel, Error>) in
            switch result {
            case .success(let response):
                let leagues = response.countrys
                self?.delegate?.presentLeagues(data: leagues)
                DispatchQueue.main.async {
                    self?.delegate?.renderTableView()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setViewDelegate (delegate : LeaguesListViewPresenterDelegateAlias){
        self.delegate = delegate
    }
    
    func navigateToLeagueDetailsViewController(league: LeagueModel){
        let leagueDetailsViewController = Storyboards.details.instance.instantiateViewController(withIdentifier: String(describing: LeagueDetailsViewController.self)) as! LeagueDetailsViewController
        let leagueDetailsPresenter = LeagueDetailsPresenter(LeagueDetailsView: leagueDetailsViewController, league: league)
        leagueDetailsViewController.leagueDetailsPresenter = leagueDetailsPresenter
        leagueDetailsViewController.modalPresentationStyle = .fullScreen
        delegate?.navigationController?.pushViewController(leagueDetailsViewController, animated: true)
    }
}
