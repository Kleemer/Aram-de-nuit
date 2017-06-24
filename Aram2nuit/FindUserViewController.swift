//
//  FindUserViewController.swift
//  Aram2nuit
//
//  Created by Thibs on 23/06/2017.
//  Copyright © 2017 Yasine Ammar. All rights reserved.
//

import UIKit
import Alamofire
import Toaster

class FindUserViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var recentSearchTable: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    
    var summoner:User = User()
    var servers = ["EUW", "RU", "KR", "BR", "OC", "JP", "NA", "EUN", "TR", "LA1", "LA2"]
    var oldSearchData : [Search] = [Search]()
    
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
    
    //TABLE MANAGEMENT
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recentSearchTable.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        if (oldSearchData[indexPath.row].image?.image != nil)
        {
            cell.imageView?.image = oldSearchData[indexPath.row].image?.image
        }
        else
        {
            cell.imageView?.downloadedFromInCell(link: oldSearchData[indexPath.row].urlPic, tableView: recentSearchTable, item: oldSearchData[indexPath.row])
        }
        cell.textLabel?.text = oldSearchData[indexPath.row].name
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (oldSearchData.count)
    }
    
    // API CALLS
    func getUser(summonerName: String, completion : @escaping (_ name: String, _ id : Int, _ accountId: Int,
        _ profileIconId : Int, _ summonerLevel : Int) -> Void) {
        
        LolAPIRouter.setServer(serverPick: servers[pickerView.selectedRow(inComponent: 0)])
        
        Alamofire.request(LolAPIRouter.getSummoner(summonerName))
            .responseJSON{
                response in
                self.searchButton.isEnabled = true
                guard response.result.isSuccess else {
                    print("Error while getting summoner : \(String(describing: response.result.error))")
                    ToastView.appearance().backgroundColor = #colorLiteral(red: 1, green: 0.3005838394, blue: 0.2565174997, alpha: 1)
                    Toast(text:"No internet connection !").show()
                    completion("", 0, 0, 0, 0)
                    return
                }
                
                guard let responseJSON = response.result.value as? [String : Any] else {
                    print ("Invalid JSON from API")
                    completion("", 0, 0, 0, 0)
                    return
                }

                if (responseJSON["status"] != nil)
                {
                    ToastView.appearance().backgroundColor = #colorLiteral(red: 1, green: 0.3005838394, blue: 0.2565174997, alpha: 1)
                    Toast(text:"User not found !").show()
                    completion("", 0, 0, 0, 0)
                    return
                }
                completion(responseJSON["name"] as! String,
                           responseJSON["id"] as! Int,
                           responseJSON["accountId"] as! Int,
                           responseJSON["profileIconId"] as! Int,
                           responseJSON["summonerLevel"] as! Int)

        }
        return
    }
    
    
    
    //SEARCH BUTTON ACTION
    @IBAction func searchSummoner()
    {
        getUser(summonerName: searchBar.text!,
                completion: { [unowned self] name, id, accountId, profileIconId, summonerLevel in
                    self.summoner = User(name : name, id : id, profileIconId: profileIconId, summonerLevel : summonerLevel, accountId : accountId)
                    //CHANGE THE VIEW
                    if (accountId > 0) {
                        self.performSegue(withIdentifier: "UserDetails", sender: self)
                    }
                    /*
                    self.getMatchs(summonerId: self.summoner.accountId, completion: {_ in
                        return
                    })*/
                    
        })
        searchButton.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UserDefaults.standard.setValue(nil, forKey: "recentSearch")
        searchButton.isEnabled = true
        pickerView.dataSource = self
        pickerView.delegate = self
        
        recentSearchTable.dataSource = self
        recentSearchTable.delegate = self
        
        if let data = UserDefaults.standard.data(forKey: "recentSearch") {
            oldSearchData = (NSKeyedUnarchiver.unarchiveObject(with: data) as? [Search])!
            //oldSearchData[0].image?.downloadedFromInCell(link: oldSearchData[0].urlPic, tableView: recentSearchTable, item: oldSearchData[0])
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "UserDetails" {
            if let userViewController = segue.destination as? UserDetailsViewController {
                userViewController.user = self.summoner as? User
                userViewController.server = servers[pickerView.selectedRow(inComponent: 0)]
                let imageView=UIImageView()

                let search:Search = Search(name:summoner.name, urlPic: "https://avatar.leagueoflegends.com/" + userViewController.server! + "/" + summoner.name + ".png", image: imageView)
                imageView.downloadedFromInCell(link: "https://avatar.leagueoflegends.com/" + userViewController.server! + "/" + summoner.name + ".png", tableView: recentSearchTable, item: search)
                
                oldSearchData.insert(search, at: 0)
                recentSearchTable.reloadData()
                let encodedData = NSKeyedArchiver.archivedData(withRootObject: oldSearchData)
                UserDefaults.standard.setValue(encodedData, forKey: "recentSearch")
            }
        }
    }
    

}
