//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Rogério Tavares on 20/10/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct ContentView: View {
    @State private var round = 1
    @State private var score = 0
    @State private var showingScore = false
    @State private var showingEndScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var descriptionAlert = ""
    @State private var buttonTapped: Int? = nil
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 400).ignoresSafeArea()
            VStack {
                Spacer()
                Text("Adivinhe a bandeira")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Toque na bandeira da")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        FlagButton(source: countries[number], number: number) {
                            flagTapped(number)
                        }
                        .opacity(buttonTapped != nil && buttonTapped != number ? 0.25 : 1)
                        .animation(.easeInOut, value: buttonTapped)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Pontuação: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Text("Rodada: \(round)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }.padding()
        }.alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(descriptionAlert)
        }.alert("Fim de Jogo!", isPresented: $showingEndScore) {
            Button("Reiniciar", action: reset)
        } message: {
            Text("Você terminou o jogo com \(score) pontos")
        }
    }
    
    func flagTapped(_ number: Int) {
        buttonTapped = number
        if number == correctAnswer {
            scoreTitle = "Acertou"
            score += 1
            descriptionAlert = "Sua pontuação é \(score)"
        } else {
            scoreTitle = "Errou"
            descriptionAlert = "Errado! Essa é a bandeira da \(countries[number])"
        }
        
        if(round < 8) {
            showingScore = true
        } else {
            showingEndScore = true
        }
        
    }
    
    func askQuestion() {
        round += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        buttonTapped = nil
    }
    
    func reset() {
        round = 1
        score = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        buttonTapped = nil
    }
}

struct FlagButton: View {
    var source: String
    var number: Int
    var action: () -> Void
    @State private var degrees = 0.0
    
    var body: some View {
        Button {
            withAnimation(.easeInOut) {
                degrees += 360
            }
            self.action()
        } label: {
            Image(source)
                .renderingMode(.original)
                .clipShape(Capsule())
                .shadow(radius: 5)
        }.rotation3DEffect(.degrees(degrees), axis: (x: 0, y: 1, z: 0))
    }
}

@available(iOS 15.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11")
    }
}

