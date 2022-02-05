//
//  FavouriteLeaguesPresenter.swift
//  SportsApp
//
//  Created by admin on 2/5/22.
//  Copyright © 2022 admin. All rights reserved.
//

import Foundation
class FavouriteLeaguesPresenter : FavouriteLeaguesPresenterProtocol {
    
    var favouriteLeagues : [FavouriteLeagueModel]?
    var view  : FavouriteLeaguesControllerProtocol
    
    init(view : FavouriteLeaguesControllerProtocol) {
        self.view = view
        getFavouriteLeagues()
    }
    func getFavouriteLeagues(){
        favouriteLeagues = DataManager.fetchFromStorage()
        view.displayFavouriteLeagues()
    }
    
    func getDataCount() -> Int {
        print(favouriteLeagues?.count)
        return favouriteLeagues?.count ?? 0
    }
    
    func getItemAtIndex(index: Int) -> FavouriteLeagueModel? {
        return favouriteLeagues?[index]
    }
    
    
    
    
    
    
    
    
}
