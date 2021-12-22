//
//  ContentView.swift
//  BetterRest
//
//  Created by Rogério Tavares on 27/10/21.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Quando você quer acordar?")) {
                    DatePicker("Insira uma data", selection: $wakeUp, displayedComponents: .hourAndMinute).labelsHidden()
                }
                Section(header: Text("Quantidade desejada de sono")) {
                    Stepper("\(sleepAmount.formatted()) horas", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                Section(header: Text("Consumo diário de café") ) {
                    Picker(coffeeAmount == 1 ? "1 xícara" : "\(coffeeAmount) xícaras", selection: $coffeeAmount) {
                        ForEach(1...20, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }
                if(calculateBedtime.count > 0){
                    Section(header: Text("Resultado")) {
                        Text("\(calculateBedtime)").font(.largeTitle).fontWeight(.heavy)
                    }
                }
            }
            .navigationTitle("BetterRest")
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var calculateBedtime: String {
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            return sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            return ""
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
