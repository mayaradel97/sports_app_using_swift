//
//  LeaguesTableViewCell.swift
//  Sports
//
//  Created by MacOSSierra on 2/18/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import UIKit

class LeaguesTableViewCell: UITableViewCell {


    
    @IBOutlet weak var videoButtonOutlet: UIButton!
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var leagueImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
