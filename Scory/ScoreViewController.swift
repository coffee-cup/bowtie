//
//  ScoreViewController.swift
//  Scory
//
//  Created by Jake Runzer on 2017-08-15.
//  Copyright © 2017 Jake Runzer. All rights reserved.
//

import UIKit

protocol NumPadDelegate {
    func valueChanged(value: Int)
    func valueSubmitted(value: Int)
}

class ScoreViewController: UIViewController, NumPadDelegate {

    @IBOutlet weak var btnNegative: UIButton!
    @IBOutlet weak var lblScore: UILabel!
    
    var player: Player!
    var game: Game!
    
    var numPadViewController: NumPadViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = player.name
        
        btnNegative.setTitleColor(Styles.darkText, for: .selected)
        btnNegative.setTitleColor(Styles.dimText, for: .normal)
        
        numPadViewController = self.childViewControllers.first as? NumPadViewController
        numPadViewController?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func negativeButtonDidTouch(_ sender: Any) {
        btnNegative.isSelected = !btnNegative.isSelected
    }
    
    func valueChanged(value: Int) {
        lblScore.text = btnNegative.isSelected
            ? "\(value * -1)"
            : "\(value)"
    }
    
    func valueSubmitted(value: Int) {
        let num = btnNegative.isSelected ? value * -1 : value
        print(num)
//        Player.addScore(game: game, player: player, value: value)
//        self.navigationController?.popViewController(animated: true)
    }

    func set(game: Game, player: Player) {
        self.game = game
        self.player = player
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
