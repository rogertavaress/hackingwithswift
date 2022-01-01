//
//  WebSiteModel.swift
//  project-4
//
//  Created by Rogério Tavares on 01/01/22.
//

import Foundation

struct WebSiteModel {
    var name: String
    var link: String
    var url: URL
    
    init(_ name: String, link: String) {
        self.name = name
        guard let newURL = URL(string: "https://\(link)") else {
            fatalError("URL invalid error / Link: \(link)")
        }
        self.link = link
        self.url = newURL
    }
}
