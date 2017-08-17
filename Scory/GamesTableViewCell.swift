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
    @IBOutlet weak var lblWinner: UILabel!
    @IBOutlet weak var imageTie: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setTie(isTie: true)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTie(isTie: Bool) {
        imageTie.isHidden = !isTie
        lblWinner.isHidden = isTie
    }
    
    func set(game: Game) {
        let playerNames = game.players.map { $0.name }
        lblGameName.text = game.name
        lblPlayers.text = playerNames.joined(separator: ", ")
        lblDate.text = game.formatedDate
        
        if let winner = game.winner() {
            setTie(isTie: false)
            viewWinner.backgroundColor = winner.colour
            lblWinner.text = String(winner.name.characters.first!)
        } else {
            setTie(isTie: true)
            viewWinner.backgroundColor = Styles.grey
        }
    }
}
