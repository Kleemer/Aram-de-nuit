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
                print(data)
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

class UserDetailsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    public var user:User?
    public var server:String?
    var matches:[Match] = [Match]()
    
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
                print(responseJSON.index(forKey: "match"))
                completion([Match]())
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = user?.name
        iconImage.downloadedFrom(link: "https://avatar.leagueoflegends.com/" + server! + "/" + (user?.name)! + ".png")
        
        
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
