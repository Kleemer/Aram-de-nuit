//
//  SearchViewCell.swift
//  Aram2nuit
//
//  Created by Benjamin on 29/06/2017.
//  Copyright © 2017 Yasine Ammar. All rights reserved.
//

import UIKit

class SearchViewCell: UITableViewCell {

    @IBOutlet weak var summonerImage: UIImageView!
    @IBOutlet weak var servLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
