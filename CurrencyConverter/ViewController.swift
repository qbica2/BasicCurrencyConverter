//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Mehmet Kubilay Akdemir on 19.01.2023.
//

import UIKit

class ViewController: UIViewController, DataTransfer {

    
    
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    let apiKey = "xe12H923CCbIewa2hafRg1DJNlMnJ3A9"
    let baseURL = "https://api.apilayer.com/exchangerates_data/"
    
    var symbolsDictionary = [String : String]()
    
    var shortCurrencies = [String]()
    var longCurrencies = [String]()
    var isFirstCurrency = Bool()
    var selectedFirstCurrency = ""
    var selectedSecondCurrency = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllCurriencies()
        
        fromLabel.layer.cornerRadius = 8
        toLabel.layer.cornerRadius = 8
        resultLabel.layer.cornerRadius = 8
        fromLabel.layer.masksToBounds = true
        toLabel.layer.masksToBounds = true
        resultLabel.layer.masksToBounds = true
        
        fromLabel.isUserInteractionEnabled = true
        toLabel.isUserInteractionEnabled = true
        let fromLabelGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectCurrencyToConvert))
        let toLabelGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectCurrencyToConvertTo))
        fromLabel.addGestureRecognizer(fromLabelGestureRecognizer)
        toLabel.addGestureRecognizer(toLabelGestureRecognizer)

    }
    
    func passDataBack(data: String) {
        
        if isFirstCurrency {
            selectedFirstCurrency = data
            fromLabel.text = "  From: \(data)"
        } else {
            selectedSecondCurrency = data
            toLabel.text = "  To: \(data)"
        }

    }
    
    @objc func selectCurrencyToConvert(){
        isFirstCurrency = true
        performSegue(withIdentifier: "toPicker", sender: nil)
    }
    
    @objc func selectCurrencyToConvertTo(){
        isFirstCurrency = false
        performSegue(withIdentifier: "toPicker", sender: nil)
    }
    
    func getAllCurriencies(){
        
        let url = baseURL  + "symbols"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "apiKey")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
//                alert göster
                print(error!)
            } else {
                
                if data != nil {
                    
                    do {
                        
                        let jsonRespone = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        DispatchQueue.main.async {
                            if let symbols = jsonRespone["symbols"] as? [String: String] {
                            
                                let sorted = symbols.sorted { $0.key < $1.key }
                                
                                self.shortCurrencies = Array(sorted.map({ $0.key }))
                                self.longCurrencies = Array(sorted.map({ $0.value }))
                                self.symbolsDictionary = symbols
                                
                            }

                        }
                        
                        
                    } catch {
                        print("error")
                    }
                    
                    
                }
                
            }
        }
        
        task.resume()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPicker" {
            let destinationVC = segue.destination as! PickerTableTableViewController
            destinationVC.list = symbolsDictionary
            destinationVC.shortCurrenciesList = shortCurrencies
            destinationVC.longCurrenciesList = longCurrencies
            destinationVC.delegate = self
        }
    }

    
    
    @IBAction func didTappedConvertButton(_ sender: Any) {
    }
    
}

