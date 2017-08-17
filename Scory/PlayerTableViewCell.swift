//
//  PlayerTableViewCell.swift
//  Scory
//
//  Created by Jake Runzer on 2017-08-15.
//  Copyright © 2017 Jake Runzer. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var viewScore: UIView!
    @IBOutlet weak var viewTurns: UIView!
    @IBOutlet weak var lblTurns: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewTurns.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(player: Player, game: Game) {
        lblName.text = player.name
        lblScore.text = "\(player.totalScore())"
        viewScore.backgroundColor = player.colour
        lblTurns.text = "\(player.numTurns())"
        viewTurns.backgroundColor = player.scores.count < game.maxTurns()
            ? Styles.red
            : Styles.purple
    }

}
