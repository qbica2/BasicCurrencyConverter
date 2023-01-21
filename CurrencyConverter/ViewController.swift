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
    @IBOutlet weak var currencyFromLabel: UILabel!
    @IBOutlet weak var currencyToLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    let apiKey = "xe12H923CCbIewa2hafRg1DJNlMnJ3A9"
    let baseURL = "https://api.apilayer.com/exchangerates_data/"
    
    var symbolsDictionary = [String : String]()
    
    var shortCurrencies = [String]()
    var longCurrencies = [String]()
    var isFirstCurrency = Bool()
    var selectedFirstCurrency = "USD"
    var selectedSecondCurrency = "TRY"
    var amount = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllCurriencies()
                
        fromLabel.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        currencyFromLabel.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        toLabel.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        currencyToLabel.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        for x  in [ fromLabel, currencyFromLabel, toLabel, currencyToLabel] {
            x!.layer.cornerRadius = 8
            x!.layer.masksToBounds = true
            x!.isUserInteractionEnabled = true
        }

        resultLabel.layer.cornerRadius = 8
        resultLabel.layer.masksToBounds = true
        
        let fromLabelTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectCurrencyToConvert))
        let currencyFromLabelTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectCurrencyToConvert))
        let toLabelTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectCurrencyToConvertTo))
        let currencyToLabelTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectCurrencyToConvert))
        
        let gestureRecognize = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognize)

        
        fromLabel.addGestureRecognizer(fromLabelTapGestureRecognizer)
        currencyFromLabel.addGestureRecognizer(currencyFromLabelTapGestureRecognizer)
        toLabel.addGestureRecognizer(toLabelTapGestureRecognizer)
        currencyToLabel.addGestureRecognizer(currencyToLabelTapGestureRecognizer)
        
        resultLabel.text = "  \(amount) \(selectedSecondCurrency)"
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    
    func passDataBack(data: String) {
        
        if isFirstCurrency {
            selectedFirstCurrency = data
            currencyFromLabel.text = selectedFirstCurrency
        } else {
            selectedSecondCurrency = data
            currencyToLabel.text = selectedSecondCurrency
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
        convert()
    }
    
    func convert(){
        let url = baseURL  + "convert?&from=\(selectedFirstCurrency)&to=\(selectedSecondCurrency)&amount=\(amountTextField.text ?? "0")"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "apiKey")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
//                alert göster
                print("error")
            } else {
                if data != nil {
                    do {
                        
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers ) as! Dictionary<String, Any>
                        print(jsonResponse)
                        DispatchQueue.main.async {
                            
                            if let result = jsonResponse["result"] as? Double {
                                self.resultLabel.text = "  \(result) \(self.selectedSecondCurrency)"
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
    
}

