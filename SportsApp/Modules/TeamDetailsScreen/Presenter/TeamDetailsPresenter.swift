//
//  TeamDetailsPresenter.swift
//  SportsApp
//
//  Created by Sarah Nassrat  on 2/5/22.
//  Copyright © 2022 admin. All rights reserved.
//

import Foundation

class TeamDetailsPresenter:TeamDetailsPresenterProtocol{

    
    
    var viewController : TeamDetailsViewControllerProtocol
    var teamModel      : TeamModel
    
    init(view :TeamDetailsViewControllerProtocol , teamModel : TeamModel) {
        self.viewController = view
        self.teamModel = teamModel
    }
    func getTeam() -> TeamModel {
        return teamModel
    }
}
