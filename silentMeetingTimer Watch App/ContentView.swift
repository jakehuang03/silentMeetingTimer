//
//  ContentView.swift
//  silentMeetingTimer Watch App
//
//  Created by Jake Huang on 2/5/25.
//

import SwiftUI

struct ContentView: View {
    @State private var meetingDuration = 30
    @State private var remainingTime = 30 * 60
    @State private var isRunning = false
    @State private var elapsedTime = 0
    @State private var timer: Timer?
    
    let intervals = [5, 10, 15, 30, 60]
    
    var body: some View {
        VStack {
            Text("Meeting Timer")
                .font(.headline)
            
            if isRunning {
                Text(formatTime(remainingTime))
            } else {
                Picker("Duration", selection: $meetingDuration) {
                    ForEach(intervals, id: \.self) { time in Text("\(time) minutes").tag(time)
                    }
                }
                .pickerStyle(.navigationLink)
            }
            
            Button(isRunning ? "Stop" : "Start") {
                isRunning ? stopTimer(): startTimer()
                
            }
            .padding()
            
        }
    }
    
    func startTimer() {
        remainingTime = meetingDuration * 60
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            remainingTime -= 1
            if remainingTime == 0 {
                WKInterfaceDevice.current().play(.success)
                stopTimer()
            }
        }
    }
    func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}


#Preview {
    ContentView()
}
