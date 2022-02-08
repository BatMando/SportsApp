//
//  SportsListPresenter.swift
//  SportsApp
//
//  Created by Mohamed Ahmed on 03/02/2022.
//  Copyright © 2022 admin. All rights reserved.
//

import Foundation
class SportsListPresenter : SportsPresenter{
    //MARK: - properties
    var sports : [SportModel] = []
    weak var view : presenterToViewDelegate?
    
    //MARK: - Life Cycle
    init(view : presenterToViewDelegate){
        self.view = view
        getSports()
    }
    
    //MARK: - Methods
    func getSports(){
        NetworkManager().request(fromEndpoint: .allSports, httpMethod: .get,parameters: nil) { [weak self] (result:Result<GetAllSportsResponseModel, Error>) in
            switch result {
            case .success(let response):
                self?.sports = response.sports ?? []
                DispatchQueue.main.async {
                    self?.view?.reloadDataInCollectionView()
                }
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

