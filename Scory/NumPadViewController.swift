//
//  NumPadViewController.swift
//  Scory
//
//  Created by Jake Runzer on 2017-08-28.
//  Copyright © 2017 Jake Runzer. All rights reserved.
//

import UIKit

class NumPadViewController: UIViewController {

    @IBOutlet weak var btnZero: UIButton!
    @IBOutlet weak var btnOne: UIButton!
    @IBOutlet weak var btnTwo: UIButton!
    @IBOutlet weak var btnThree: UIButton!
    @IBOutlet weak var btnFour: UIButton!
    @IBOutlet weak var btnFive: UIButton!
    @IBOutlet weak var btnSix: UIButton!
    @IBOutlet weak var btnSeven: UIButton!
    @IBOutlet weak var btnEight: UIButton!
    @IBOutlet weak var btnNine: UIButton!
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    var numButtons: [UIButton] = []
    
    var value: String = ""
    var delegate: NumPadDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        numButtons = [
            btnZero,
            btnOne,
            btnTwo,
            btnThree,
            btnFour,
            btnFive,
            btnSix,
            btnSeven,
            btnEight,
            btnNine
        ]
        
        configureButtons()
    }
    
    func configureButtons() {
        for btn in numButtons {
            styleButton(button: btn)
            btn.addTarget(self, action: #selector(numButtonDidTouch(sender:)), for: .touchUpInside)
        }
        
        styleButton(button: btnBack)
        btnBack.addTarget(self, action: #selector(backButtonDidTouch(sender:)), for: .touchUpInside)
        
        styleButton(button: btnNext)
        btnNext.addTarget(self, action: #selector(nextButtonDidTouch(sender:)), for: .touchUpInside)
    }
    
    func styleButton(button: UIButton) {
        button.setTitleColor(Styles.darkText, for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(26)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func numButtonDidTouch(sender: UIButton!) {
        if let text = sender.titleLabel?.text {
            value = "\(value)\(text)"
        }
    }

    @objc func backButtonDidTouch(sender: UIButton!) {
        if value != "" {
            value = String(value[..<value.index(before: value.endIndex)])
        }
    }
    
    @objc func nextButtonDidTouch(sender: UIButton!) {
        if let numValue = Int(value) {
            delegate?.numberSubmitted(value: numValue)
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
