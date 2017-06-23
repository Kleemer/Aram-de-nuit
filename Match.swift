//
//  Match.swift
//  Aram2nuit
//
//  Created by Thibs on 23/06/2017.
//  Copyright © 2017 Yasine Ammar. All rights reserved.
//

import UIKit

class Match: NSObject {
    var lane:String = ""
    var gameId:Int = 0
    var champion:Int = 0
    var platformId:Int = 0
    var timestamp:String = ""
    var queue:Int = 0
    var role:String = ""
    var season:Int = 0
    
    init(lane:String, gameId:Int, champion:Int, platformId:Int, timestamp:String, queue:Int, role:String, season:Int)
    {
        self.lane = lane
        self.gameId = gameId
        self.champion = champion
        self.platformId = platformId
        self.timestamp = timestamp
        self.queue = queue
        self.role = role
        self.season = season
    }
}
