//
//  DetailController.swift
//  challenge-1
//
//  Created by Rogério Tavares on 29/12/21.
//

import UIKit

class DetailController: UIViewController {
    @IBOutlet var flagImageView: UIImageView?
    var imageSelected: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let selected = imageSelected else {
            return
        }
        
        title = selected.capitalized
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareImage))
        
        flagImageView?.image = UIImage(named: selected)
    }
    
    @objc func shareImage() {
        guard let image = flagImageView?.image else { return }
        
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: [])
        
        present(activityViewController, animated: true)
    }
}
