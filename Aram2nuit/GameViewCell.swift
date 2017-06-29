//
//  GameViewCell.swift
//  Aram2nuit
//
//  Created by Benjamin on 29/06/2017.
//  Copyright © 2017 Yasine Ammar. All rights reserved.
//

import UIKit

class GameViewCell: UITableViewCell {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var item0: UIImageView!
    @IBOutlet weak var item1: UIImageView!
    @IBOutlet weak var item2: UIImageView!
    @IBOutlet weak var item3: UIImageView!
    @IBOutlet weak var item4: UIImageView!
    @IBOutlet weak var item5: UIImageView!
    @IBOutlet weak var item6: UIImageView!
    @IBOutlet weak var winLoseRectangle: UIView! // Win : 6ED56E Lose : A63935
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
