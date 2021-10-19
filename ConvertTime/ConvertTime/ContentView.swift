//
//  ContentView.swift
//  ConvertTime
//
//  Created by Rogério Tavares on 18/10/21.
//

import SwiftUI

struct ContentView: View {
    @State private var value = "0"
    @State private var respRange = 0
    let respRangeValues = ["segundos", "minutos", "horas", "dias"]
    let differences = [1000, 1000*60, 1000*60*60, 1000*60*60*24]
    var resp: Double {
        let inputValue = Double(value) ?? 0
        let difference = Double(differences[respRange])
        let response:Double = inputValue / difference
        
        return response
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Valor em milissegundos (ex: 1000)")) {
                    TextField("Valor em milissegundos (ex: 1000)", text: $value).keyboardType(.numberPad)
                }
                Section(header: Text("Escolha a unidade")) {
                    Picker("Escolha a unidade", selection: $respRange) {
                        ForEach(0 ..< respRangeValues.count) {
                            Text("\(self.respRangeValues[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    Text("\(value) milissegundos em \(resp, specifier: "%.2f") \(respRangeValues[respRange])")
                }
            }
            .navigationBarTitle("ConvertTime")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 11")
    }
}
