//
//  ContentView.swift
//  Practice Multiplication Tables
//
//  Created by Rogério Tavares on 17/11/21.
//

import SwiftUI

struct ContentView: View {
    @State private var table = 0
    @State private var quantity = 1
    @State private var difficulty = 1
    @State private var started = false
    
    var body: some View {
        
        NavigationView {
            Form {
                Section("Regras da partida") {
                    Picker("Quais tabuadas deseja praticar", selection: $table) {
                        ForEach(2..<13) {
                            Text("Até a tabuada de \($0)")
                        }
                    }
                    Stepper("\(quantity == 1 ? "1 pergunta" : "\(quantity) perguntas")", value: $quantity, in: 1...5)
                    Picker("Dificuldade", selection: $difficulty) {
                        ForEach(0..<3) {
                            switch $0 {
                            case 0:
                                Text("Fácil")
                            case 1:
                                Text("Médio")
                            case 2:
                                Text("Difícil")
                            default:
                                Text("teste")
                            }
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }.disabled(started)
                Section {
                    Button(started ? "Terminar agora": "Iniciar agora") {
                        started.toggle()
                    }
                }
            }
            .navigationTitle("Pratique a tabuada")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
