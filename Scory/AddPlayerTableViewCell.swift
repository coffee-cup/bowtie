//
//  AddPlayerTableViewCell.swift
//  Scory
//
//  Created by Jake Runzer on 2017-08-13.
//  Copyright © 2017 Jake Runzer. All rights reserved.
//

import UIKit

class AddPlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var lblPlayerName: UILabel!
    @IBOutlet weak var btnColour: UIButton!
    
    var colourChangeCallback: ((UIColor) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func ColourDidTouch(_ sender: Any) {
        changeColour()
    }
    
    func changeColour() {
        let randomColour = UIColor.randomHue()
        
        UIView.animate(withDuration: 0.250, animations: {
            self.btnColour.backgroundColor = randomColour
        })
        
        colourChangeCallback?(randomColour)
    }
}
