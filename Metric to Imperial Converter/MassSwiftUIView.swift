//
//  MassSwiftUIView.swift
//  Metric to Imperial Converter
//
//  Created by Diana Dashinevich on 05/12/2024.
//

import SwiftUI

struct MassSwiftUIView: View {
    @State private var massFromUser = 0.0
    @State private var selectedUnitMetric = "kg"
    @State private var selectedUnitImperial = "lb"
    @State private var convertedMass = 0.0
    
    let unitsOfMeasurementMetric = ["mg", "g", "kg"]
    let unitsOfMeasurementImperial = ["oz", "lb", "st"]
    
    func massConversion(_ mass: Double) -> Double {
        var massInKg: Double
   
        switch selectedUnitMetric {
        case "mg":
            massInKg = mass / 1_000_000
        case "g":
            massInKg = mass / 1000
        case "kg":
            massInKg = mass
        default:
            massInKg = mass
        }
        
        switch selectedUnitImperial {
        case "oz":
            return massInKg * 35.274
        case "lb":
            return massInKg * 2.20462
        case "st":
            return massInKg * 0.157473
        default:
            return massInKg
        }
    }
    
    @FocusState private var amountIsFocused: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Mass in metric units") {
                    TextField("Amount", value: $massFromUser, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Units of measurement", selection: $selectedUnitMetric) {
                        ForEach(unitsOfMeasurementMetric, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                }
                .foregroundColor(.indigo)
                
                Section("Mass in Imperial Units") {
                    Picker("Convert to", selection: $selectedUnitImperial) {
                        ForEach(unitsOfMeasurementImperial, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                }
                .foregroundColor(.indigo)
                
                .onTapGesture {
                    self.amountIsFocused = false
                }
                
                Button {
                    convertedMass = massConversion(massFromUser)
                } label: {
                    Text("Convert")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .listRowBackground(Color.indigo)
                .foregroundColor(.white)
                
                Section("Result") {
                    HStack {
                        Text("\(convertedMass, specifier: "%.3f")")
                        Spacer()
                        Divider()
                        Text(selectedUnitImperial)
                    }
                }
            }
            .navigationTitle("Mass")
        }
    }
}

#Preview {
    MassSwiftUIView()
}
