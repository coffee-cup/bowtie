//
//  GameViewController.swift
//  Scory
//
//  Created by Jake Runzer on 2017-08-15.
//  Copyright © 2017 Jake Runzer. All rights reserved.
//

import UIKit
import RealmSwift

class GameViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var game: Game!
    var selectedPlayer: Player?
    
    var notificationToken: NotificationToken!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = game.name
        
        tableView.dataSource = self
        tableView.delegate = self
        
        notificationToken = Store.notifier {
            self.game = Store.get(byId: self.game.id, type: Game.self)!
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ScoreSegue", let scoreViewController = segue.destination as? ScoreViewController {
            scoreViewController.player = selectedPlayer!
        }
    }
    
    deinit {
        notificationToken.stop()
    }
    
    // Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlayer = game.players[indexPath.row]
        
        performSegue(withIdentifier: "ScoreSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // Table View Datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return game.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell") as! PlayerTableViewCell
        
        let player = game.players[indexPath.row]
        let totalScore = player.scores.reduce(0) { acc, score in
            return acc + score.value
        }
        let turnCounts = game.players.map { player in
            return player.scores.count
        }
        let maxTurns = turnCounts.max() ?? 0
        
        cell.lblName.text = player.name
        cell.lblScore.text = "\(totalScore)"
        cell.lblTurns.text = "\(player.scores.count)"
        cell.viewTurns.backgroundColor = player.scores.count < maxTurns
            ? red
            : purple
        
        return cell
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
