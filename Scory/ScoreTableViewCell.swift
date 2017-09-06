//
//  ScoreTableViewCell.swift
//  Scory
//
//  Created by Jake Runzer on 2017-09-06.
//  Copyright © 2017 Jake Runzer. All rights reserved.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {

    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblRound: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(score: Score, round: Int) {
        lblScore.text = String(score.value)
        lblRound.text = String(round)
    }

}
