//
//  ContentView.swift
//  CoinFlip Watch App
//
//  Created by Matt Keyzer on 2/25/24.
//

import SwiftUI

struct ContentView: View {
    @State private var flipResult = "Unflipped" 
    @State private var coinImage = ""

    var body: some View {
        VStack {
            Text("Flip the Coin!")
            Button(action: {
                flipCoin()
            }) {
                Text("Flip!")
            }
            HStack{
                Image(systemName: coinImage)
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text(flipResult) 
            }
            
        }
        .padding()
    }
    
    private func flipCoin() {
        let randomNumber = Double.random(in: 0.1...1.0)
        if randomNumber <= 0.5 {
            flipResult = "Heads"
            coinImage = "dollarsign.circle"
        } else {
            flipResult = "Tails"
            coinImage = "dollarsign.circle.fill"
        }
        debugPrint("Hello, you flipped a coin!")
    }
}


#Preview {
    ContentView()
}
