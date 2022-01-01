//
//  TableViewController.swift
//  project-4
//
//  Created by Rogério Tavares on 01/01/22.
//

import UIKit

protocol TableViewControllerDelegate {
    var websites: [WebSiteModel] { get set }
}

class TableViewController: UITableViewController, TableViewControllerDelegate {
    
    var websites = [WebSiteModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "RogerBrowser"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        websites += [
            WebSiteModel("Apple", link: "apple.com"),
            WebSiteModel("Hacking with swift", link: "hackingwithswift.com"),
            WebSiteModel("Github", link: "github.com"),
            WebSiteModel("Rogério Tavares - Site", link: "rogeriotavares.dev"),
        ]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WebSiteCell", for: indexPath)

        cell.textLabel?.text = websites[indexPath.row].name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "WebViewPage") as? ViewController else {
            return
        }
        
        viewController.tableviewDelegate = self
        viewController.initWebSite = websites[indexPath.row]
        
        navigationController?.pushViewController(viewController, animated: true)
    }

}
