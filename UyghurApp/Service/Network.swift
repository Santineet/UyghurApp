//
//  Network.swift
//  UyghurApp
//
//  Created by Mairambek on 11/26/19.
//  Copyright © 2019 YashlikAvazi. All rights reserved.
//

class Network {
    //singleton
    static let instance = Network()
    
    private var reachability:Reachability?
    
    //    MARK:    Internet check function.
    //    MARK:    Функция для проверки интернета.
    func isConnected() -> Bool {
        
        do {
            try reachability = Reachability.init()
            
            if (self.reachability?.connection) == .wifi || (self.reachability?.connection) == .cellular {
                return true
            } else if self.reachability?.connection == .unavailable {
                return false
            } else {
                return false
            }
        }catch{
            return false
        }
    }

}
