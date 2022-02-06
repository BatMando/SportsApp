//
//  LeagueDetailsPresenterProtocol.swift
//  SportsApp
//
//  Created by Sarah Nassrat  on 2/5/22.
//  Copyright © 2022 admin. All rights reserved.
//

import Foundation

protocol LeagueDetailsPresenterProtocol{
    func getUpcomingEvents()
    func getUpcomingEventWithIndex(index:Int) -> EventModel
    func getUpcomingEventsCount() -> Int
    func getLeagueName()->String
    func getLatestResults()
    func getLatestResultWithIndex(index:Int) -> EventModel
    func getLatestResultsCount() -> Int
    func addLeagueToFavourite()
    func checkIsFavourite() -> Bool
    func removeFromFavourites(id : String)
    func getLeaugeID () -> String
    func getTeams()
    func getTeamWithIndex(index:Int) -> TeamModel
    func getTeamsCount() -> Int
}
