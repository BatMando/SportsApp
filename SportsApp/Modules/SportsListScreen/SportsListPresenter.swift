//
//  SportsListPresenter.swift
//  SportsApp
//
//  Created by Mohamed Ahmed on 03/02/2022.
//  Copyright © 2022 admin. All rights reserved.
//

import Foundation


protocol SportsPresenter {
    func getSports()
    func getSport(atIndex : IndexPath)->SportModel
    func getSportsCount()->Int
}

protocol presenterToViewDelegate : AnyObject{
    func reloadTableView()
}

class SportsListPresenter : SportsPresenter{
        
    var sports : [SportModel] = []
    weak var view : presenterToViewDelegate?
    
    init(view : presenterToViewDelegate){
        self.view = view
        getSports()
    }
    
    
    func getSports(){
        NetworkManager().request(fromEndpoint: .allSports, httpMethod: .get) { [weak self] (result:Result<GetAllSportsResponseModel, Error>) in
            switch result {
            case .success(let response):
                print("aaa")
                self?.sports = response.sports ?? []
                self?.view?.reloadTableView()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getSportsCount() -> Int {
        return sports.count
    }
    
    func getSport(atIndex: IndexPath)->SportModel{
        return sports[atIndex.row]
    }
    
    
    
    
}

