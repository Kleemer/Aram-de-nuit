//
//  LolAPIRouter.swift
//  Aram2nuit
//
//  Created by Thibs on 23/06/2017.
//  Copyright © 2017 Yasine Ammar. All rights reserved.
//

import UIKit
import Alamofire

public enum LolAPIRouter : URLRequestConvertible
{

    static var server = "euw1"
    static var baseURLPath = "https://"+server+".api.riotgames.com/lol"
    static let XRiotToken = "RGAPI-647ae2a2-177c-4fd0-aab2-d05ad796ef78"
    
    case getSummoner(String)
    case getHistory(Int)
    case getMatchStats(Int)
    
    
    public static func setServer(serverPick:String)
    {
        switch serverPick {
        case "EUW":
            server = "euw1"
            break
        case "RU" :
            server = "ru"
            break
        case "KR" :
            server = "kr"
            break
        case "BR" :
            server = "br1"
            break
        case "OC" :
            server = "oc1"
            break
        case "JP" :
            server = "jp"
            break
        case "NA" :
            server = "na1"
            break
        case "EUN" :
            server = "eun1"
            break
        case "TR" :
            server = "tr1"
            break
        case "LA1" :
            server = "la1"
            break
        case "LA2" :
            server = "la2"
            break
        default :
            server = "euw1"
            break
        }
        baseURLPath = "https://"+server+".api.riotgames.com/lol"
    }
    
    var method: HTTPMethod {
        switch self {
        case .getSummoner, .getMatchStats, .getHistory:
            return .get
        }
    }
    
    var path : String {
        switch self {
        case .getSummoner(let summonerName):
            return "/summoner/v3/summoners/by-name/" + summonerName
        case .getHistory(let summonerId) :
            return "/match/v3/matchlists/by-account/" + String(summonerId) + "/recent"
        case .getMatchStats(let matchId) :
            return "/match/v3/matches/" + String(matchId)
        default:
            return ""
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let parameters : [String : Any] = {
            switch self {
            case .getSummoner:
                return [:]
            default:
                return [:]
            }
        }()
        
        let url = try LolAPIRouter.baseURLPath.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.setValue(LolAPIRouter.XRiotToken, forHTTPHeaderField: "X-Riot-Token")
        request.timeoutInterval = TimeInterval(10 * 500)
        print(request.url?.absoluteString)
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
