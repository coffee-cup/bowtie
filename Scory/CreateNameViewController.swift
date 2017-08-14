//
//  CreateNameViewController.swift
//  Scory
//
//  Created by Jake Runzer on 2017-08-13.
//  Copyright © 2017 Jake Runzer. All rights reserved.
//

import UIKit

class CreateNameViewController: UIViewController {

    @IBOutlet weak var fieldName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fieldName.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func namePrimaryAction(_ sender: Any) {
        self.performSegue(withIdentifier: "AddPlayersSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddPlayersSegue", let createPlayersViewController = segue.destination as? CreatePlayersViewController {
            createPlayersViewController.gameName = fieldName.text ?? ""
            
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
        }
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
