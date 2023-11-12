//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Lucas Vieira on 10/11/23.
//

import SwiftUI

struct BlueTitle: ViewModifier {
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
                .font(.title)
                .bold()
                .foregroundStyle(.blue)
                .padding(5)
        }
    }
}

extension View {
    func bluetitled() -> some View {
        modifier(BlueTitle())
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Text("Hello, everyone!")
                
        }
        .padding()
        .bluetitled()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
