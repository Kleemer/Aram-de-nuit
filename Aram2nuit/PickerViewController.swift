//
//  PickerViewController.swift
//  Aram2nuit
//
//  Created by Thibs on 23/06/2017.
//  Copyright © 2017 Yasine Ammar. All rights reserved.
//

import UIKit

class PickerViewController: UIPickerView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var servers = ["EUW", "RU", "KR", "BR", "OC", "JP", "NA", "EUN", "TR", "LA1", "LA2"]
    
    override func numberOfRows(inComponent component: Int) -> Int {
        return servers.count
    }
    
    


}
