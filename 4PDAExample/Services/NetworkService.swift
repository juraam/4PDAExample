//
//  NetworkService.swift
//  4PDAExample
//
//  Created by Admin on 19.12.16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit
import ReachabilitySwift

class NetworkService: NSObject {
    static var sharedInstance = NetworkService()
    
    let reachability = Reachability()!
    var internetAvailable: Bool = false
    
    override init() {
        super.init()
        reachability.whenReachable = {  [weak self] (reachability:Reachability) in
            self?.internetAvailable = true
        }
        reachability.whenUnreachable = { [weak self] (reachability:Reachability) in
            self?.internetAvailable = false
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
}
