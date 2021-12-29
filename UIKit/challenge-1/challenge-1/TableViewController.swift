//
//  ViewController.swift
//  challenge-1
//
//  Created by Rogério Tavares on 29/12/21.
//

import UIKit

class TableViewController: UITableViewController {
    
    var countries = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "FlagsApp"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
        
        cell.textLabel?.text = countries[indexPath.row].capitalized
        
        cell.imageView?.image = UIImage(named: countries[indexPath.row])
        cell.imageView?.layer.borderWidth = 1
        cell.imageView?.layer.borderColor = UIColor.separator.cgColor
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailController = storyboard?.instantiateViewController(withIdentifier: "DetailScreen") as? DetailController else {
            return
        }
        
        detailController.imageSelected = countries[indexPath.row]
        navigationController?.pushViewController(detailController, animated: true)
    }
}

