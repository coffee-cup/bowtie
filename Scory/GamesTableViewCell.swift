//
//  GamesTableViewCell.swift
//  Scory
//
//  Created by Jake Runzer on 2017-08-12.
//  Copyright © 2017 Jake Runzer. All rights reserved.
//

import UIKit

class GamesTableViewCell: UITableViewCell {

    @IBOutlet weak var viewWinner: UIView!
    @IBOutlet weak var lblGameName: UILabel!
    @IBOutlet weak var lblPlayers: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewWinner.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
