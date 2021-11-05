//
//  ContentView.swift
//  WordScramble
//
//  Created by Rogério Tavares on 05/11/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            Section("Topo") {
                Text("Header")
            }
            
            Section("Content") {
                ForEach(0..<5, id: \.self) {
                    Text("Linha \($0)").foregroundColor(.red)
                }
            }
            
            Section("Rodapé") {
                Text("Footer")
            }
        }
        .listStyle(.grouped)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11")
    }
}
