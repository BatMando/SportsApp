//
//  FavouriteLeaguesPresenter.swift
//  SportsApp
//
//  Created by admin on 2/5/22.
//  Copyright © 2022 admin. All rights reserved.
//

import Foundation
class FavouriteLeaguesPresenter : FavouriteLeaguesPresenterProtocol {
    // MARK: - Properties
    var favouriteLeagues : [FavouriteLeagueModel]?
    var view  : FavouriteLeaguesControllerProtocol
    
    // MARK: - Life Cycle
    init(view : FavouriteLeaguesControllerProtocol) {
        self.view = view
        getFavouriteLeagues()
    }
    
    // MARK: - Methods
    func getFavouriteLeagues(){
        favouriteLeagues = DataManager.fetchFromStorage()
        view.displayFavouriteLeagues()
    }
    
    func daleteItem (indexPath : IndexPath){
        favouriteLeagues?.remove(at: indexPath.row)
    }
    
    func getDataCount() -> Int {
        return favouriteLeagues?.count ?? 0
    }
    
    func getItemAtIndex(index: Int) -> FavouriteLeagueModel? {
        return favouriteLeagues?[index]
    }
}
