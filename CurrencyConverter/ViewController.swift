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
    
    let apiKey = "xe12H923CCbIewa2hafRg1DJNlMnJ3A9"
    let baseURL = "https://api.apilayer.com/exchangerates_data/"
    
    var symbolsDictionary = [String : String]()
    
    
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
                                
                                for symbol in symbols {
                                    self.symbolsDictionary[symbol.key] = symbol.value
                                }
                                
                            }

                        }
                        
                        
                    } catch {
                        print("error")
                    }
                    
                    
                }
                
            }
        }
        
        task.resume()
        
        performSegue(withIdentifier: "toPicker", sender: nil)
    }

    
    
    @IBAction func didTappedConvertButton(_ sender: Any) {
    }
    
}

