//
//  UserDetailsViewController.swift
//  Aram2nuit
//
//  Created by Thibs on 24/06/2017.
//  Copyright © 2017 Yasine Ammar. All rights reserved.
//

import UIKit
import Alamofire

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFromInCell(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit, tableView:UITableView, item: Search) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
                item.image?.image = image
                tableView.reloadData()
            }
            }.resume()
    }
    func downloadedFromInCell(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit, tableView:UITableView, match:Match) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { print (error); return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
                match.champIcon.image = image
                tableView.reloadData()
            }
            }.resume()
    }

    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        let linkURL = link.replacingOccurrences(of: " ", with: "+")
        guard let url = URL(string: linkURL) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
    func downloadedFromInCell(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit, tableView: UITableView, item: Search) {
        let linkURL = link.replacingOccurrences(of: " ", with: "+")
        guard let url = URL(string: linkURL) else { return }
        downloadedFromInCell(url: url, contentMode: mode, tableView: tableView, item: item)
    }
    func downloadedFromInCell(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit, tableView: UITableView, match:Match) {
        let linkURL = link.replacingOccurrences(of: " ", with: "+")
        guard let url = URL(string: linkURL) else { return }
        downloadedFromInCell(url: url, contentMode: mode, tableView: tableView, match: match)
    }

}

class UserDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var matchTable: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    public var user:User?
    public var server:String?
    var matches:[Match] = [Match]()
    
    func getSummonerStats(match: Match, completion : @escaping (_ stats:PlayerStatsGlob) -> Void)
    {
        Alamofire.request(LolAPIRouter.getMatchStats(match.gameId))
            .responseJSON(){
                response in guard response.result.isSuccess else {
                    print("Error while getting summonerStats : \(response.result.error)")
                    completion(PlayerStatsGlob())
                    return
                }
                
                guard let responseJSON = response.result.value as? [String : Any] else {
                    print("Invalid JSON from API")
                    completion(PlayerStatsGlob())
                    return
                }
                var result:PlayerStatsGlob = PlayerStatsGlob()
                guard let participantsStats = responseJSON["participants"] as! [[String:Any]]? else {completion(result); return}
                for stat in participantsStats{
                    if (stat["championId"] as? Int == match.champion)
                    {
                        let killsStats = stat["stats"] as! [String:Any]
                        result.kills = killsStats["kills"] as! Int
                        result.assists = killsStats["assists"] as! Int
                        result.deaths = killsStats["deaths"] as! Int
                        result.isOK = true
                    }
                }
                completion(result)
        }

    }
    
    func getMatchs(summonerId: Int, completion : @escaping (_ matches:[Match]) -> Void)
    {
        Alamofire.request(LolAPIRouter.getHistory(summonerId))
            .responseJSON(){
                response in guard response.result.isSuccess else {
                    print("Error while getting summoner : \(response.result.error)")
                    completion([Match]())
                    return
                }
                
                guard let responseJSON = response.result.value as? [String : Any] else {
                    print("Invalid JSON from API")
                    completion([Match]())
                    return
                }
                
                let arr = responseJSON["matches"] as! [[String:Any]]
                var result = [Match]()
                for match in arr {
                    let matchO = Match()
                    matchO.lane = match["lane"] as! String
                    matchO.gameId = match["gameId"] as! Int
                    matchO.champion = match["champion"] as! Int
                    matchO.platformId = match["platformId"] as! String
                    matchO.season = match["season"] as! Int
                    matchO.queue = match["queue"] as! Int
                    matchO.role = match["role"] as! String
                    matchO.timestamp = match["timestamp"] as! Int
                    result.append(matchO)
                }
                completion(result)
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = matchTable.dequeueReusableCell(withIdentifier: "matchCell", for: indexPath)
        let currMatch = matches[indexPath.row]
        if (currMatch.statsSummoner == nil)
        {
            getSummonerStats(match: currMatch, completion: { playerStat in
                if (playerStat.isOK){
                    self.matches[indexPath.row].statsSummoner = playerStat
                }
                self.matchTable.reloadData()
                
            })
        }
        else
        {
            cell.textLabel?.text = "\((currMatch.statsSummoner?.kills)!)/\((currMatch.statsSummoner?.deaths)!)/\((currMatch.statsSummoner?.assists)!)"
        }
        if (currMatch.champIcon.image == nil)
        {
            currMatch.champIcon.image = UIImage()
            currMatch.champIcon.downloadedFromInCell(link: "https://ddragon.leagueoflegends.com/cdn/7.13.1/img/champion/" + ChampionNameByKey.getNameById(id: currMatch.champion) + ".png", tableView: matchTable, match:currMatch)
        }
        else
        {
            cell.imageView?.image = currMatch.champIcon.image
        }
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = user?.name
        iconImage.downloadedFrom(link: "https://avatar.leagueoflegends.com/" + server! + "/" + (user?.name)! + ".png")
        matchTable.dataSource = self
        matchTable.delegate = self
        
        getMatchs(summonerId: (user?.accountId)!, completion: {
            matchlist in
            for match in matchlist
            {
                match.champIcon.downloadedFromInCell(link: "https://ddragon.leagueoflegends.com/cdn/7.13.1/img/champion/" + ChampionNameByKey.getNameById(id: match.champion) + ".png", tableView: self.matchTable, match: match)
            }

            self.matches = matchlist
            return
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
