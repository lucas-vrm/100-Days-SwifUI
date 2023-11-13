//
//  ContentView.swift
//  BetterRest
//
//  Created by Lucas Vieira on 13/11/23.
//

import SwiftUI
import CoreML


struct ContentView: View {
    @State private var wakeUp = Date.now
    @State private var sleepAmount = 8.0
    
    var body: some View {
        VStack {
            
            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...11, step: 0.25)
            
            DatePicker("Please enter a date", selection: $wakeUp, in: Date.now...)
        }
    }
    
    func exampleDates() {
        // create a second Date instance set to one day in seconds from now
        let tomorrow = Date.now.addingTimeInterval(86400)

        // create a range from those two
        let range = Date.now...tomorrow
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
