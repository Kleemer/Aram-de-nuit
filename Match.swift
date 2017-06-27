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
    var platformId:String = ""
    var timestamp:Int = 0
    var queue:Int = 0
    var role:String = ""
    var season:Int = 0
    var champIcon:UIImageView = UIImageView()
    var statsSummoner: PlayerStatsGlob? = nil
    var allStats : [PlayerStatsGlob]? = nil
    
    override init()
    {
        
    }
    
    init(lane:String, gameId:Int, champion:Int, platformId:String, timestamp:Int, queue:Int, role:String, season:Int)
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
