//
//  FindUserViewController.swift
//  Aram2nuit
//
//  Created by Thibs on 23/06/2017.
//  Copyright © 2017 Yasine Ammar. All rights reserved.
//

import UIKit
import Alamofire

class FindUserViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    
    var summoner:User = User()
    
    func getUser(summonerName: String, completion : @escaping (_ name: String, _ id : Int, _ accountId: Int,
        _ profileIconId : Int, _ summonerLevel : Int) -> Void) {
        

        Alamofire.request(LolAPIRouter.getSummoner(summonerName))
            .responseJSON{
                response in guard response.result.isSuccess else {
                    print("Error while guetting summoner : \(response.result.error)")
                    completion("", 0, 0, 0, 0)
                    return
                }
                
                guard let responseJSON = response.result.value as? [String : Any] else {
                    print ("Invalid JSON from API")
                    completion("", 0, 0, 0, 0)
                    return
                }
                
                print(responseJSON)
                completion("", 0, 0, 0, 0)
        }
        return
    }
    
    @IBAction func searchSummoner()
    {
        getUser(summonerName: searchBar.text!,
                completion: { [unowned self] name, id, accountId, profileIconId, summonerLevel in
                    self.summoner = User(name : name, id : id, profileIconId: profileIconId, summonerLevel : summonerLevel, accountId : accountId)
                    
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
