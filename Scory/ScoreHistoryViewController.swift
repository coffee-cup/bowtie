//
//  ScoreHistoryViewController.swift
//  Scory
//
//  Created by Jake Runzer on 2017-09-06.
//  Copyright © 2017 Jake Runzer. All rights reserved.
//

import UIKit
import RealmSwift

class ScoreHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var notificationToken: NotificationToken!
    var player: Player!
    var playerId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        self.navigationItem.title = "\(player.name)'s Scores"
        
        notificationToken = Store.notifier {
            if let player = Store.get(byId: self.playerId, type: Player.self) {
                self.player = player
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        notificationToken.stop()
    }
    
    func set(player: Player) {
        self.player = player
        self.playerId = player.id
    }
    
    // Table View Delegate
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let round = player.scores.count - indexPath.row - 1
        let score = player.scores[round]
        
        Score.delete(score: score)
    }
    
    // Table View Datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return player.scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell") as! ScoreTableViewCell
        
        let round = player.scores.count - indexPath.row - 1
        let score = player.scores[round]
        
        cell.set(score: score, round: round)
        
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
