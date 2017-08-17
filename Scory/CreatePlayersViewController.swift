//
//  CreatePlayersViewController.swift
//  Scory
//
//  Created by Jake Runzer on 2017-08-13.
//  Copyright © 2017 Jake Runzer. All rights reserved.
//

import UIKit

class CreatePlayersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var fieldPlayerName: UITextField!
    @IBOutlet weak var btnAddPlayer: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnCreate: UIButton!
    
    var gameName: String!
    var players: [NewPlayer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        fieldPlayerName.becomeFirstResponder()
        btnCreate.isEnabled = false
        btnAddPlayer.isEnabled = false
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 80
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playerNameDidChange(_ sender: Any) {
        if let playerName = fieldPlayerName.text {
            btnAddPlayer.isEnabled = playerName.trim() != ""
        }
    }
    
    @IBAction func addPlayerDidTouch(_ sender: Any) {
        addPlayer()
    }
    
    @IBAction func playerNamePrimaryAction(_ sender: Any) {
        addPlayer()
    }
    
    @IBAction func CreateDidTouch(_ sender: Any) {
        let _ = Game.create(name: gameName, newPlayers: players)
        navigationController?.popToRootViewController(animated: true)
    }
    
    func addPlayer() {
        if let playerName = fieldPlayerName.text {
            if playerName.trim() == "" {
                return
            }
            
            let newPlayer = NewPlayer(name: playerName, colour: UIColor.randomHue())
            
            players.insert(newPlayer, at: 0)
            fieldPlayerName.text = ""
            tableView.reloadData()
            
            fieldPlayerName.becomeFirstResponder()
            btnCreate.isEnabled = true
        }
    }
    
    func changeNewPlayerColour(colour: UIColor, index: Int) {
        let newPlayer = players[index]
        players.remove(at: index)
        players.insert(NewPlayer(name: newPlayer.name, colour: colour), at: index)
        tableView.reloadData()
    }
    
    // Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        players.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    // Table View Datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddPlayerCell") as! AddPlayerTableViewCell
        
        let newPlayer = players[indexPath.row]
        cell.set(newPlayer: newPlayer)
        
        cell.colourChangeCallback = { colour in
            self.changeNewPlayerColour(colour: colour, index: indexPath.row)
        }
        
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
