//
//  ContentView.swift
//  TemperatureConverter
//
//  Created by Lucas Vieira on 06/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var temp = 0.0
    @FocusState private var amountIsFocused: Bool
    
    let temperatures = ["Celsius", "Farenheit", "Kelvin"]
    @State private var selectedUnit = "Celsius"
    
    var toCelsius: Double {
        let setTemperature = selectedUnit
        let t = temp
        
        switch setTemperature {
        case "Celsius":
            return t
        case "Farenheit":
            return (0.55*t - 17.78)
        case "Kelvin":
            return (t - 273.15)
        default:
            return t
        }
            
    }
    
    var toFarenheit: Double {
        let setTemperature = selectedUnit
        let t = temp
        
        switch setTemperature {
        case "Celsius":
            return 1.8*t + 32
        case "Farenheit":
            return t
        case "Kelvin":
            return 1.8*t - 459.67
        default:
            return t
        }
            
    }
    
    var toKelvin: Double {
        let setTemperature = selectedUnit
        let t = temp
        
        switch setTemperature {
        case "Celsius":
            return t + 273.15
        case "Farenheit":
            return 0.55*t + 255.37
        case "Kelvin":
            return t
        default:
            return t
        }
            
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Temperature") {
                    TextField("Amount", value: $temp, format: .number)
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    
                    Picker("Unit", selection: $selectedUnit) {
                        ForEach(temperatures, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section ("Celsius"){
                    Text(toCelsius, format: .number)
                }
                
                Section ("Farenheit"){
                    Text(toFarenheit, format: .number)
                }
                
                Section ("Kelvin"){
                    Text(toKelvin, format: .number)
                }
                
                
            }.navigationTitle("Temperature Converter")
                .toolbar {
                    if amountIsFocused {
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
