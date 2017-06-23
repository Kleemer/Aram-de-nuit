//
//  ItemAPI.swift
//  Aram2nuit
//
//  Created by Thibs on 23/06/2017.
//  Copyright © 2017 Yasine Ammar. All rights reserved.
//

import UIKit

class User: NSObject {
    var name : String
    var id : Int
    var profileIconId : Int
    var summonerLevel : Int
    var accountId : Int
    
    override init()
    {
        self.name = ""
        self.profileIconId = 0
        self.summonerLevel = 0
        self.id = 0
        self.accountId = 0
    }
    
    init(name: String, id : Int, profileIconId : Int, summonerLevel: Int, accountId : Int) {
        self.name = name
        self.profileIconId = profileIconId
        self.summonerLevel = summonerLevel
        self.id = id
        self.accountId = accountId
    }
}
