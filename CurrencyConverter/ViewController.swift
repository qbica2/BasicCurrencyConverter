//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Mehmet Kubilay Akdemir on 19.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fromLabel.layer.cornerRadius = 8
        toLabel.layer.cornerRadius = 8
        resultLabel.layer.cornerRadius = 8
        fromLabel.layer.masksToBounds = true
        toLabel.layer.masksToBounds = true
        resultLabel.layer.masksToBounds = true

    }

    
    
    @IBAction func didTappedConvertButton(_ sender: Any) {
    }
    
}

