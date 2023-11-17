//
//  ContentView.swift
//  BetterRest
//
//  Created by Lucas Vieira on 13/11/23.
//

import SwiftUI
import CoreML


struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    init(wakeUp: Date = defaultWakeTime, sleepAmount: Double = 8.0, coffeeAmount: Int = 1, alertTitle: String = "", alertMessage: String = "", showingAlert: Bool = false) {
        self.wakeUp = wakeUp
        self.sleepAmount = sleepAmount
        self.coffeeAmount = coffeeAmount
        self.alertTitle = alertTitle
        self.alertMessage = alertMessage
        self.showingAlert = showingAlert
        self.calculateBedtime()
    }
    
    var body: some View {
        NavigationStack {
            Form {
                VStack(alignment: .leading, spacing: 0) {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .onChange(of: wakeUp) { newValue in
                            self.calculateBedtime()
                        }
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                        .onChange(of: sleepAmount) { newValue in
                            self.calculateBedtime()
                        }
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Daily coffee intake")
                        .font(.headline)
                    
                    Picker(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", selection: $coffeeAmount){
                        ForEach(0..<21) {
                            Text($0 == 1 ? "1 cup" : "\($0) cups")
                        }
                    }
                    .onChange(of: coffeeAmount) { newValue in
                        self.calculateBedtime()
                    }
                }
                VStack(alignment: .leading, spacing: 10) {
                    Text("Your ideal bedtime is...")
                        .font(.headline)
                    Text(alertMessage)
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                }
            }
            .navigationTitle("BetterRest")
        }
        .onAppear {
            self.calculateBedtime()
        }
        .onDisappear {
            self.calculateBedtime()
        }
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 3600
            let minutes = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour+minutes), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTIme = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTIme.formatted(date: .omitted, time: .shortened)
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime"
        }
        
        showingAlert = true
        
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
