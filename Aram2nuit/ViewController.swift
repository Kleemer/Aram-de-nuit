//
//  ViewController.swift
//  Aram2nuit
//
//  Created by Yasine Ammar on 20/06/2017.
//  Copyright © 2017 Yasine Ammar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
        
    @IBOutlet weak var SummonerTextField: UITextField!
    @IBOutlet weak var ServerButton: UIButton!
    @IBOutlet weak var serverPicked: UILabel!
    @IBOutlet weak var serverPicker: UIPickerView!
    
    var servers = ["EUW", "NA", "EUNE", "LAN", "KR", "RU", "TR", "BR", "OCE", "LAS", "JP" ]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        serverPicker.delegate = self
        serverPicker.dataSource = self
        serverPicker.isHidden = true
    }

        
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return servers.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return servers [row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        serverPicked.text = servers[row]
        serverPicker.isHidden = true
    }
    

    @IBAction func actionChangeServer(_ sender: Any) {
        serverPicker.isHidden = false
        print("hey")
    }
}
