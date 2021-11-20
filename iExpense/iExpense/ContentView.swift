//
//  ContentView.swift
//  iExpense
//
//  Created by Rogério Tavares on 20/11/21.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("tapCount") private var tapCount = 0
    @State private var user = User(name: "Roger", city: "Recife")
    
    var body: some View {
        Button("Contador: \(tapCount)") {
            tapCount += 1
        }
        Button("Salvar usuário") {
            let encoder = JSONEncoder()
            
            if let data = try? encoder.encode(user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }
    }
}

struct User: Codable {
    let name: String
    let city: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
