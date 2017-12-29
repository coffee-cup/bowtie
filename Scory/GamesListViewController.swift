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
    var selectedGame: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Large title
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        
//        navigationController?.navigationBar.barTintColor = UIColor.white
        
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
        if segue.identifier == "GameSegue", let gameViewController = segue.destination as? GameViewController {
            gameViewController.set(game: selectedGame!)
        }
    }
    
    deinit {
        notificationToken.stop()
    }
    
    func deleteGame(at indexPath: IndexPath) {
        let game = games[indexPath.row]
        Game.delete(game: game)
    }
    
    func copyGame(at indexPath: IndexPath) {
        let game = games[indexPath.row]
        let _ = Game.duplicate(game: game)
    }
    
    // Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedGame = games[indexPath.row]
        
        performSegue(withIdentifier: "GameSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: { (_, _, success: (Bool) -> Void) in
            self.deleteGame(at: indexPath)
            success(true)
        })
        
        let copyAction = UIContextualAction(style: .normal, title: "Copy", handler: { (_, _, success: (Bool) -> Void) in
            self.copyGame(at: indexPath)
            success(true)
        })

        let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction, copyAction])
        swipeConfig.performsFirstActionWithFullSwipe = true
        
        return swipeConfig
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        deleteGame(at: indexPath)
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
        cell.set(game: game)
        
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
