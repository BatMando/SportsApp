//
//  FavouritePresenterProtocol.swift
//  SportsApp
//
//  Created by admin on 2/5/22.
//  Copyright © 2022 admin. All rights reserved.
//

import Foundation
protocol FavouriteLeaguesPresenterProtocol {
    func getDataCount()->Int
    func getItemAtIndex(index : Int)->FavouriteLeagueModel?
    func getFavouriteLeagues()
}
