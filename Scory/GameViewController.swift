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
    @IBOutlet weak var btnSort: UIBarButtonItem!
    
    var gameId: String!
    var game: Game!
    var players: [Player] = []
    
    var selectedPlayer: Player?
    
    var notificationToken: NotificationToken!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = game.name
        
        tableView.dataSource = self
        tableView.delegate = self
        
        notificationToken = Store.notifier {
            if let game = Store.get(byId: self.gameId, type: Game.self) {
                self.game = game
                self.navigationItem.title = game.name
                self.sort()
            }
        }
        
        sort()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ScoreSegue", let scoreViewController = segue.destination as? ScoreViewController {
            scoreViewController.set(game: game, player: selectedPlayer!)
        }
    }
    
    deinit {
        notificationToken.stop()
    }

    func set(game: Game) {
        self.game = game
        self.gameId = game.id
        self.players = Array(game.players)
    }
    
    // Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlayer = players[indexPath.row]
        
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
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell") as! PlayerTableViewCell
        
        let player = players[indexPath.row]
        cell.set(player: player, game: game)
        
        return cell
    }
    
    // Sorting
    
    func sort(by sortOption: SortOption = Settings.sort) {
        btnSort.title = sortOption.rawValue
        Settings.sort = sortOption
        
        switch sortOption {
        case .Name:
            players = players.sorted(by: { $0.name < $1.name })
        case .Score:
            players = players.sorted(by: { $0.totalScore() > $1.totalScore() })
        case .Turns:
            players = players.sorted(by: { $0.numTurns() < $1.numTurns() })
        }
        
        tableView.reloadData()
    }
    
    @IBAction func sortDidTouch(_ sender: Any) {
        let sortMenu = UIAlertController(title: "Sort", message: nil, preferredStyle: .actionSheet)
        
        let nameAction = UIAlertAction(title: SortOption.Name.rawValue, style: .default, handler: { action in
            self.sort(by: .Name)
        })
        let scoreAction = UIAlertAction(title: SortOption.Score.rawValue, style: .default, handler: { action in
            self.sort(by: .Score)
        })
        let turnsAction = UIAlertAction(title: SortOption.Turns.rawValue, style: .default, handler: { action in
            self.sort(by: .Turns)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        sortMenu.addAction(nameAction)
        sortMenu.addAction(scoreAction)
        sortMenu.addAction(turnsAction)
        sortMenu.addAction(cancelAction)
        
        self.present(sortMenu, animated: true, completion: nil)
    }
    
    @IBAction func editButtonDidTouch(_ sender: Any) {
        let editMenu = UIAlertController(title: "Change Game Name", message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { action in
            if let textField = editMenu.textFields?.first, let text = textField.text {
                Store.update {
                    self.game.name = text
                    Store.realm.add(self.game, update: true)
                }
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        editMenu.addTextField(configurationHandler: { textfield in
            textfield.keyboardType = .alphabet
            textfield.autocapitalizationType = .words
        })
        editMenu.addAction(okAction)
        editMenu.addAction(cancelAction)
        
        self.present(editMenu, animated: true, completion: nil)
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

