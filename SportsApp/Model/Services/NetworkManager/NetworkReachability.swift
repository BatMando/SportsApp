//
//  NetworkConnection.swift
//  SportsApp
//
//  Created by Mohamed Ahmed on 06/02/2022.
//  Copyright © 2022 admin. All rights reserved.
//import UIKit
import Network
import Foundation

class NetworkReachability {
    @available(iOS 12.0, *)
    class func monitorNetwork(){
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            //this closure get called every time connection state changes
            if path.status != .unsatisfied {
                //publish connected notf
                DispatchQueue.main.async {
                NotificationCenter.default.post(Notification.init(name: Notification.Name("ConnectedToNetwork")))
                print("We're connected!")
                }
            } else {
                //publish not Connected notf
                DispatchQueue.main.async {
                    NotificationCenter.default.post(Notification.init(name: Notification.Name("NotInternetConnection")))
                    print("No connection.")
                }
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
}
