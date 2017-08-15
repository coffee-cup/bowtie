//
//  ScoreViewController.swift
//  Scory
//
//  Created by Jake Runzer on 2017-08-15.
//  Copyright © 2017 Jake Runzer. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {

    @IBOutlet weak var fieldScore: UITextField!
    @IBOutlet weak var btnNegative: UIButton!
    @IBOutlet weak var btnAddScore: UIBarButtonItem!
    
    var player: Player!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = player.name
        
        fieldScore.becomeFirstResponder()
        btnNegative.setTitleColor(darkText, for: .selected)
        btnNegative.setTitleColor(dimText, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func scoreEditingDidChange(_ sender: Any) {
        btnAddScore.isEnabled = (fieldScore.text ?? "") != ""
    }
    
    @IBAction func negativeButtonDidTouch(_ sender: Any) {
        btnNegative.isSelected = !btnNegative.isSelected
    }
    
    @IBAction func addScoreDidTouch(_ sender: Any) {
        Store.update {
            let newScore = Score.create(value: score())
            player.scores.append(newScore)
            Store.realm.add(player, update: true)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func score() -> Int {
        let absScore = Int(fieldScore.text ?? "0") ?? 0
        return btnNegative.isSelected ? absScore * -1 : absScore
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
