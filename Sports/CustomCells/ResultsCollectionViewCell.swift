//
//  ResultsCollectionViewCell.swift
//  Sports
//
//  Created by MacOSSierra on 2/22/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import UIKit

class ResultsCollectionViewCell: UICollectionViewCell
{
    
    @IBOutlet weak var againstImage: UIImageView!
    @IBOutlet weak var awayTeamName: UILabel!
    @IBOutlet weak var homeTeamName: UILabel!
    
    @IBOutlet weak var dateAndTime: UILabel!
    @IBOutlet weak var awayTeamScore: UILabel!
    @IBOutlet weak var homeTeamScore: UILabel!
}
