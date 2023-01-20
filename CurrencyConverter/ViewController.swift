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
        
        fromLabel.isUserInteractionEnabled = true
        toLabel.isUserInteractionEnabled = true
        let fromLabelGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(getAllCurriencies))
        let toLabelGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(getAllCurriencies))
        fromLabel.addGestureRecognizer(fromLabelGestureRecognizer)
        toLabel.addGestureRecognizer(toLabelGestureRecognizer)

    }
    
    @objc func getAllCurriencies(){
        performSegue(withIdentifier: "toPicker", sender: nil)
    }

    
    
    @IBAction func didTappedConvertButton(_ sender: Any) {
    }
    
}

