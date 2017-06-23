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
    static let XRiotToken = "RGAPI-a0cecf77-fe35-4846-8339-6c0faa535701"
    
    case getSummoner(String)
    case getHistory(Int)
    
    
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
        case .getSummoner :
            return .get
        case .getHistory :
            return .get
        }
    }
    
    var path : String {
        switch self {
        case .getSummoner(let summonerName):
            return "/summoner/v3/summoners/by-name/" + summonerName
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
        request.timeoutInterval = TimeInterval(10 * 1000)
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
