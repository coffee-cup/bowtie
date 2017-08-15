//
//  GamesListViewController.swift
//  Scory
//
//  Created by Jake Runzer on 2017-05-08.
//  Copyright © 2017 Jake Runzer. All rights reserved.
//

import UIKit
import RealmSwift

class GamesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var notificationToken: NotificationToken!
    var games = Game.all()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Large title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UIColor.white
        
        notificationToken = Store.notifier {
            self.games = Game.all()
            self.tableView.reloadData()
        }
        
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GameSegue" {
            
        }
    }
    
    deinit {
        notificationToken.stop()
    }
    
    // Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GameSegue", sender: self)
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
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell") as! GamesTableViewCell
        
        let game = games[indexPath.row]
        let playerNames = game.players.map { $0.name }
        
        cell.lblGameName.text = game.name
        cell.lblPlayers.text = playerNames.joined(separator: ", ")
        
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
