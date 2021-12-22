//
//  ContentView.swift
//  PracticeMultiplicationTables
//
//  Created by Rogério Tavares on 17/11/21.
//

import SwiftUI

enum CheckEnum {
    case Right
    case Wrong
    case Awaiting
}

struct ContentView: View {
    @State private var table = 0
    @State private var quantity = 1
    @State private var difficulty = 1
    @State private var started = false
    @State private var resps = [String]()
    @State private var questions = [Question]()
    @State private var checkQuestions = [String]()
    
    var body: some View {
        
        NavigationView {
            Form {
                if !started {
                    Section("Regras da partida") {
                        Picker("Quais tabuadas deseja praticar", selection: $table) {
                            ForEach(2..<13) {
                                Text("Até a tabuada de \($0)")
                            }
                        }
                        .padding(5)
                        Stepper("\(quantity == 1 ? "1 pergunta" : "\(quantity) perguntas")", value: $quantity, in: 1...10)
                            .padding(5)
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
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(5)
                    }.disabled(started)
                }
                Section {
                    if started {
                        Button("Terminar agora") {
                            endGame()
                        }
                        Button("Conferir respostas") {
                            checkGame()
                        }
                    } else {
                        Button("Iniciar agora") {
                            startGame()
                        }
                    }
                }
                if started {
                    Section {
                        ForEach(0..<quantity, id: \.self) { index in
                            HStack {
                                Text("\(questions[index].leftNumber) X \(questions[index].rightNumber) =")
                                TextField("\(questions[index].leftNumber) X \(questions[index].rightNumber)", text: $resps[index])
                                    .keyboardType(.numberPad)
                                Text(checkQuestions[index])
                            }
                            .padding()
                        }
                    }
                }
            }
            .navigationTitle("Pratique a tabuada")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    func getCheckStatus(_ status: CheckEnum) -> String {
        switch status {
        case .Right:
            return "Certo"
        case .Wrong:
            return "Errado"
        case .Awaiting:
            return "Aguardando"
        }
    }
    
    func startGame() {
        resps = (0..<quantity).map { _ in "" }
        questions = (0..<quantity).map { _ in generate() }
        checkQuestions = (0..<quantity).map { _ in getCheckStatus(CheckEnum.Awaiting) }
        
        withAnimation {
            started = true
        }
    }
    
    func endGame() {
        withAnimation {
            started = false
        }
    }
    
    func checkGame() {
        (0..<questions.count).forEach { index in
            let isItCorrect = questions[index].check(resps[index])
            
            if isItCorrect {
                checkQuestions[index] = getCheckStatus(.Right)
            }else {
                checkQuestions[index] = getCheckStatus(.Wrong)
            }
            
            if resps[index] == "" {
                checkQuestions[index] = getCheckStatus(.Awaiting)
            }
        }
    }
    
    func generate() -> Question {
        let rangeLeftNumber = table + 2
        let leftNumber = Int.random(in: 1...rangeLeftNumber)
        var rangeDifficulty = 0
        
        switch difficulty {
        case 0:
            rangeDifficulty = 10
        case 1:
            rangeDifficulty = 20
        case 2:
            rangeDifficulty = 100
        default:
            rangeDifficulty = 10
        }
        
        let rightNumber = Int.random(in: 1...rangeDifficulty)
        let response = leftNumber * rightNumber
        
        return Question(leftNumber: leftNumber, rightNumber: rightNumber, response: response)
    }
}

struct Question {
    var leftNumber: Int
    var rightNumber: Int
    var response: Int
    
    func check(_ userRespText: String) -> Bool {
        guard let userResp = Int(userRespText) else {
            return false
        }
        
        if userResp == response {
            return true
        }
        
        return false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
