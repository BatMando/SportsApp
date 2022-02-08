//
//  Storyboards.swift
//  SportsApp
//
//  Created by admin on 1/31/22.
//  Copyright © 2022 admin. All rights reserved.
//
import UIKit
import Foundation
enum Storyboards : String {
    case main   = "Main"
    case details = "Details"
    case launchScreen  = "LaunchScreen"
    
    var instance : UIStoryboard {
        switch self {
        case .main :
            return UIStoryboard(name: Storyboards.main.rawValue, bundle: nil)
        case .details :
            return UIStoryboard(name: Storyboards.details.rawValue, bundle: nil)
            
        case .launchScreen :
            return UIStoryboard(name: Storyboards.launchScreen.rawValue, bundle: nil)
        }
        
        
    }
}
