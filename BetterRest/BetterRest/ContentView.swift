//
//  ContentView.swift
//  BetterRest
//
//  Created by Rogério Tavares on 27/10/21.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    
    var body: some View {
        VStack {
            Stepper("\(sleepAmount.formatted()) horas", value: $sleepAmount, in: 4...12, step: 0.25)
                .padding()
            DatePicker("Insira uma data", selection: $wakeUp, displayedComponents: .hourAndMinute).labelsHidden()
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
