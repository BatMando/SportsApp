//
//  LeagueDetailsViewProtocol.swift
//  SportsApp
//
//  Created by Sarah Nassrat  on 2/5/22.
//  Copyright © 2022 admin. All rights reserved.
//

import Foundation

protocol LeagueDetailsViewControllerProtocol : AnyObject{
    func reloadUpcomingEventsCollectionView()
    func reloadLatestResultsTableView()
    func reloadTeamsCollectionView()
    func didAddedToFavouriteSuccessfully()
    func didRemoveFromFavouriteSuccessfully()

}
