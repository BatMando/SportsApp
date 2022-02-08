//
//  SportsPresenter.swift
//  SportsApp
//
//  Created by admin on 2/8/22.
//  Copyright © 2022 admin. All rights reserved.
//

import Foundation
protocol SportsPresenter {
    func getSports()
    func getSport(atIndex : IndexPath)->SportModel
    func getSportsCount()->Int
}
