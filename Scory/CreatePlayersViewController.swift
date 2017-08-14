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
    var players: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        btnCreate.isEnabled = false
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playerNameDidChange(_ sender: Any) {
        if let playerName = fieldPlayerName.text {
            btnAddPlayer.isEnabled = playerName != ""
        }
    }
    
    @IBAction func addPlayerDidTouch(_ sender: Any) {
        addPlayer()
    }
    
    @IBAction func playerNamePrimaryAction(_ sender: Any) {
        addPlayer()
    }
    
    @IBAction func CreateDidTouch(_ sender: Any) {
        // Create the new game here
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    func addPlayer() {
        if let playerName = fieldPlayerName.text {
            players.append(playerName)
            fieldPlayerName.text = ""
            tableView.reloadData()
            
            fieldPlayerName.becomeFirstResponder()
            btnCreate.isEnabled = true
        }
    }
    
    // Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddPlayerCell") as! AddPlayerTableViewCell
        
        let playerName = players[indexPath.row]
        cell.lblPlayerName.text = playerName
        
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
