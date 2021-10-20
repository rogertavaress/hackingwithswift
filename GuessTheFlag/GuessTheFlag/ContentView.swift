//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Rogério Tavares on 20/10/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct ContentView: View {
    @State private var showingAlert = false
    var body: some View {
        Button("Show Alert") {
            showingAlert = true
        }
        .alert("Important message", isPresented: $showingAlert) {
            Button("Delete", role: .destructive) { }
            Button("Cancel", role: .cancel) { }
        } message : {
            Text("Pfv leia logo")
        }
    }
    
    func executeDelete() {
        print("Now deleting…")
    }
}

@available(iOS 15.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11")
    }
}
