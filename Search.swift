//
//  Search.swift
//  Aram2nuit
//
//  Created by Thibs on 24/06/2017.
//  Copyright © 2017 Yasine Ammar. All rights reserved.
//

import UIKit

class Search: NSObject, NSCoding{
    var name:String = ""
    var urlPic:String = ""
    var image:UIImageView?
    
    init(name:String, urlPic:String, image:UIImageView)
    {
        self.name = name
        self.urlPic = urlPic
        self.image = image
    }
    
    required init(coder aDecoder: NSCoder) {
        name = (aDecoder.decodeObject(forKey: "name") as? String)!
        urlPic = aDecoder.decodeObject(forKey: "urlPic") as! String
        image = aDecoder.decodeObject(forKey: "image") as! UIImageView
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey:"name")
        aCoder.encode(urlPic, forKey: "urlPic")
        aCoder.encode(image, forKey: "image")
    }
}
