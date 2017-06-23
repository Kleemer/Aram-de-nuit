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
    static let baseURLPath = "https://euw1.api.riotgames.com/lol"
    static let XRiotToken = "RGAPI-a0cecf77-fe35-4846-8339-6c0faa535701"
    
    case getSummoner(String)
    case getHistory(Int)
    
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
