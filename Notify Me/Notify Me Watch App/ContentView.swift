//
//  ContentView.swift
//  Notify Me Watch App
//
//  Created by Matt Keyzer on 2/25/24.
//

import SwiftUI
struct ContentView: View {
    @State private var timeRemaining: TimeInterval = 300
    @State private var totalTime: TimeInterval = 300
    @State private var isTimerRunning = false
    @State private var timer: Timer?
    
    var backgroundColor: Color {
        if timeRemaining <= 60 {
            return .red
        } else if timeRemaining <= 180 {
            return .orange
        } else if timeRemaining <= 300 {
            return .yellow
        } else {
            return .green
        }
    }

    var body: some View {
        VStack {
            Text("Time: \(Int(timeRemaining / 60)):\(Int(timeRemaining) % 60) minutes")
                .padding()
                .background(backgroundColor)
                .foregroundColor(.black)
            Slider(value: $timeRemaining, in: 60...600, step: 60).onChange(of: totalTime) {
                    timeRemaining = totalTime
                
            }
            Button(action: {
                if self.isTimerRunning {
                    self.stopTimer()
                } else {
                    self.startTimer()
                }
            }) {
                Text(self.isTimerRunning ? "Stop" : "Start")
            }
        }
        .padding()
        .onAppear {
            timeRemaining = totalTime
        }
        
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.timeRemaining -= 1
            if self.timeRemaining <= 0 {
                self.stopTimer()
            }
        }
        isTimerRunning = true
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
        isTimerRunning = false
    }
}

#Preview {
    ContentView()
}
