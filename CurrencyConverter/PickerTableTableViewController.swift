//
//  PickerTableTableViewController.swift
//  CurrencyConverter
//
//  Created by Mehmet Kubilay Akdemir on 20.01.2023.
//

import UIKit

class PickerTableTableViewController: UITableViewController {
    
    var list = [String : String]()
    
    var shortCurrenciesList = [String]()
    var longCurrenciesList = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    override func viewWillAppear(_ animated: Bool) {

        tableView.reloadData()

    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list.count 
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = shortCurrenciesList[indexPath.row]
        content.secondaryText = longCurrenciesList[indexPath.row]
        cell.contentConfiguration = content
                 
        return cell
    }

   
}
