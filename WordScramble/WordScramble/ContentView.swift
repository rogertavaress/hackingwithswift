//
//  ContentView.swift
//  WordScramble
//
//  Created by Rogério Tavares on 05/11/21.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        TextField("Digite a palavra", text: $newWord)
                            .autocapitalization(.none)
                    }
                    
                    Section {
                        ForEach(usedWords, id: \.self) { word in
                            HStack {
                                Image(systemName: "\(word.count).circle")
                                Text(word)
                            }
                        }
                    }
                }
                .navigationTitle(rootWord)
                .onSubmit(addNewWord)
                .onAppear(perform: startGame)
                .alert(errorTitle, isPresented: $showingError) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text(errorMessage)
                }
                
                Button("Resetar", action: startGame)
                    .padding()
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard isSynctaxCorrect(word: answer) else {
            wordError(title: "Fora das regras", message: "A palavra precisa ter mais de 2 letras e não pode ser igual a palavra '\(rootWord)'")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Palavra já usada", message: "Seja mais original")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Não é uma palavra possível", message: "Você não pode soletrar a palavra '\(rootWord)'!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Palavra não reconhecida", message: "Você não pode simplesmente inventá-los, entendeu?")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    func startGame() {
        if let startWordURL = Bundle.main.url(forResource:"start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordURL) {
                let allWords = startWords.components(separatedBy: "\n")
                
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Não conseguimos carregar o arquivo start.txt")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isSynctaxCorrect(word: String) -> Bool {
        !(word.count < 3 || rootWord == word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11")
    }
}
