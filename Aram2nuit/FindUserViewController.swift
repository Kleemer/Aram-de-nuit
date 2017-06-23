//
//  FindUserViewController.swift
//  Aram2nuit
//
//  Created by Thibs on 23/06/2017.
//  Copyright © 2017 Yasine Ammar. All rights reserved.
//

import UIKit
import Alamofire

class FindUserViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    
    var summoner:User = User()
    var servers = ["EUW", "RU", "KR", "BR", "OC", "JP", "NA", "EUN", "TR", "LA1", "LA2"]
    
    
    // PICKER MANAGEMENT
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return servers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return servers[row]
    }
    
    
    // API CALLS
    func getUser(summonerName: String, completion : @escaping (_ name: String, _ id : Int, _ accountId: Int,
        _ profileIconId : Int, _ summonerLevel : Int) -> Void) {
        
        LolAPIRouter.setServer(serverPick: servers[pickerView.selectedRow(inComponent: 0)])
        
        Alamofire.request(LolAPIRouter.getSummoner(summonerName))
            .responseJSON{
                response in guard response.result.isSuccess else {
                    print("Error while getting summoner : \(response.result.error)")
                    completion("", 0, 0, 0, 0)
                    return
                }
                
                guard let responseJSON = response.result.value as? [String : Any] else {
                    print ("Invalid JSON from API")
                    completion("", 0, 0, 0, 0)
                    return
                }
                
                print(responseJSON)
                completion(responseJSON["name"] as! String,
                           responseJSON["id"] as! Int,
                           responseJSON["accountId"] as! Int,
                           responseJSON["profileIconId"] as! Int,
                           responseJSON["summonerLevel"] as! Int)
        }
        return
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
                
                print(responseJSON)
                completion([Match]())
        }
    }
    
    @IBAction func searchSummoner()
    {
        getUser(summonerName: searchBar.text!,
                completion: { [unowned self] name, id, accountId, profileIconId, summonerLevel in
                    self.summoner = User(name : name, id : id, profileIconId: profileIconId, summonerLevel : summonerLevel, accountId : accountId)
                    //CHANGE THE VIEW
                    self.getMatchs(summonerId: self.summoner.accountId, completion: {_ in
                        return
                    })
                    
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
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
