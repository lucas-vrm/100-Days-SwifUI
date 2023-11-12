//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Lucas Vieira on 12/11/23.
//

import SwiftUI

struct MoveImage: View {
    var move: String
    
    var body: some View {
        
        Image(move)
            .resizable()
            .frame(width: 100.0, height: 100.0)
            .clipShape(RoundedRectangle(cornerRadius: 5.0))
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var moves = ["rock", "paper", "scissors"]
    @State private var computerMove = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var score = 0
    @State private var questionsAnswered = 0
    
    @State private var gameIsOver = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.red, .blue], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
                
                Text(shouldWin ? "Tap the move to WIN to" : "Tap the move to LOSE to")
                    .foregroundStyle(.white)
                    .font(.headline.weight(.heavy))

                Text(moves[computerMove])
                    .foregroundStyle(.white)
                    .font(.largeTitle.weight(.semibold))
                MoveImage(move: moves[computerMove])
                    .frame(width: 150.0, height: 120.0)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                
                Spacer()
                
                VStack(spacing: 15) {
                    
                    HStack{
                        ForEach(0..<3) { number in
                            Button {
                                moveTapped(number)
                            } label: {
                                MoveImage(move: moves[number])
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20.0))

                Spacer()
                Spacer()
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("GAME OVER!", isPresented: $gameIsOver) {
                Button("Restart", action: restart)
            } message: {
                Text("Your final score is \(score)")
            }
        
        
    }
    
    func moveTapped(_ number: Int) {
        switch moves[computerMove] {
        case "rock":
            if shouldWin {
                if moves[number] == "paper" {
                    score += 1
                    scoreTitle = "Correct"
                } else {
                    score -= 1
                    scoreTitle = "Wrong! You should've tapped PAPER"
                }
            } else {
                if moves[number] == "scissors" {
                    score += 1
                    scoreTitle = "Correct"
                } else {
                    score -= 1
                    scoreTitle = "Wrong! You should've tapped SCISSORS"
                }
            }
        case "paper":
            if shouldWin {
                if moves[number] == "scissors" {
                    score += 1
                    scoreTitle = "Correct"
                } else {
                    score -= 1
                    scoreTitle = "Wrong! You should've tapped SCISSORS"
                }
            } else {
                if moves[number] == "rock" {
                    score += 1
                    scoreTitle = "Correct"
                } else {
                    score -= 1
                    scoreTitle = "Wrong! You should've tapped ROCK"
                }
            }
        case "scissors":
            if shouldWin {
                if moves[number] == "rock" {
                    score += 1
                    scoreTitle = "Correct"
                } else {
                    score -= 1
                    scoreTitle = "Wrong! You should've tapped ROCK"
                }
            } else {
                if moves[number] == "paper" {
                    score += 1
                    scoreTitle = "Correct"
                } else {
                    score -= 1
                    scoreTitle = "Wrong! You should've tapped PAPER"
                }
            }
        default:
            print("Oh no!")
        }
        
        questionsAnswered += 1
        shouldWin.toggle()
        
        if questionsAnswered == 5 {
            gameIsOver = true
        }
        
        
        showingScore = true
    }
    
    func askQuestion() {
        computerMove = Int.random(in: 0...2)
    }
    
    func restart() {
        computerMove = Int.random(in: 0...2)
        shouldWin = Bool.random()
        
        showingScore = false
        scoreTitle = ""
        
        score = 0
        questionsAnswered = 0
        
        gameIsOver = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
