//
//  ConnectonObject.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 05/10/22.
//

import Foundation
import Alamofire

struct ConnectivityStatuses {
    static let connected = Notification.Name("connectedToInternet")
    static let notConnected = Notification.Name("notConnectedToInternet")
}

class ConnectionObject {
    static let sharedInstance = ConnectionObject()
    
    var networkManager: NetworkReachabilityManager?
    
    init() {
        self.networkManager = NetworkReachabilityManager()
    }
    
    /// Function to check the internet
    func startInternetObserver() {
//        self.networkManager?.startListening(onQueue: .main, onUpdatePerforming: { status in
//            switch status {
//            case .reachable(.cellular), .reachable(.ethernetOrWiFi):
//                NotificationCenter.default.post(name: ConnectivityStatuses.connected, object: nil)
//            case .notReachable:
//                NotificationCenter.default.post(name: ConnectivityStatuses.notConnected, object: nil)
//            default:
//                break
//            }
//        })
    }
    func isConnectedToInternet() -> Bool {
        return self.networkManager?.isReachable ?? false
    }
}
