//
//  ContentView.swift
//  Metric to Imperial Converter
//
//  Created by Diana Dashinevich on 05/12/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Physical Quantity") {
                    NavigationLink(destination: LengthSwiftUIView()) {
                        Text("Length")
                    }
                    .foregroundColor(.teal)
                    
                    NavigationLink(destination: MassSwiftUIView()) {
                        Text("Mass")
                    }
                    .foregroundColor(.indigo)
                    
                    NavigationLink(destination: CapacitySwiftUIView()) {
                        Text("Capacity")
                    }
                    .foregroundColor(.blue)
                }
            }
            .navigationTitle("Measurements")
        }
    }
}

#Preview {
    ContentView()
}
