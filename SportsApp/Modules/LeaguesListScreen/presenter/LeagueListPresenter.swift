//
//  LeagueListPresenter.swift
//  SportsApp
//
//  Created by admin on 2/8/22.
//  Copyright © 2022 admin. All rights reserved.
//

import Foundation
// MARK: - Leagues list view presenter Protocol
protocol LeaguesListViewPresenterDelegate: AnyObject{
    func presentLeagues (data : [LeagueModel])
    func renderTableView()
}
