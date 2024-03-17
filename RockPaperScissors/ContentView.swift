//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by William Koonz on 3/17/24.
//

import SwiftUI

struct ContentView: View {
    let moves = ["✊", "✋", "✌️"]
    @State private var appChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var questionCount = 1
    @State private var showingResult = false
    
    var body: some View {
        VStack {
            Text("Score: \(score)")
                .font(.headline)
            
            Text("App's Move: \(moves[appChoice])")
                .font(.system(size: 20))
            
            if shouldWin {
                Text("You should WIN!")
                    .font(.headline)
                    .foregroundColor(.green)
            } else {
                Text("You should LOSE!")
                    .font(.headline)
                    .foregroundColor(.red)
            }
            
            HStack {
                ForEach(0..<3) { index in
                    Button(action: {
                        self.playerTapped(index)
                    }) {
                        Text(self.moves[index])
                            .font(.system(size: 100))
                    }
                }
            }
        }
        .alert(isPresented: $showingResult) {
            Alert(title: Text("Game Over"), message: Text("Your score is \(score) out of 10."), dismissButton: .default(Text("Play Again")) {
                self.resetGame()
            })
        }
    }
    
    func playerTapped(_ index: Int) {
        let winningMoves = [1, 2, 0]
        let didWin = index == winningMoves[appChoice]
        
        if (didWin && shouldWin) || (!didWin && !shouldWin) {
            score += 1
        } else {
            score -= 1
        }
        
        if questionCount == 10 {
            showingResult = true
        } else {
            questionCount += 1
            appChoice = Int.random(in: 0...2)
            shouldWin.toggle()
        }
    }
    
    func resetGame() {
        score = 0
        questionCount = 1
        appChoice = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
}

#Preview {
    ContentView()
}
