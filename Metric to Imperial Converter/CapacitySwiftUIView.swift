//
//  CapacitySwiftUIView.swift
//  Metric to Imperial Converter
//
//  Created by Diana Dashinevich on 05/12/2024.
//

import SwiftUI

struct CapacitySwiftUIView: View {
    @State private var capacityFromUser = 0.0
    @State private var selectedUnitMetric = "l"
    @State private var selectedUnitImperial = "gal"
    @State private var convertedCapacity = 0.0
    
    let unitsOfMeasurementMetric = ["ml", "l"]
    let unitsOfMeasurementImperial = ["gal", "pt"]
    
    func capacityConversion(_ capacity: Double) -> Double {
        var capacityInLiters: Double
        
        switch selectedUnitMetric {
        case "ml":
            capacityInLiters = capacity / 1000
        case "l":
            capacityInLiters = capacity
        default:
            capacityInLiters = capacity
        }
        
        switch selectedUnitImperial {
        case "gal":
            return capacityInLiters * 0.264172
        case "pt":
            return capacityInLiters * 2.11338
        default:
            return capacityInLiters
        }
    }
    
    @FocusState private var amountIsFocused: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Capacity in metric units") {
                    TextField("Amount", value: $capacityFromUser, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Units of measurement", selection: $selectedUnitMetric) {
                        ForEach(unitsOfMeasurementMetric, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                }
                .foregroundColor(.blue)
                
                Section("Capacity in Imperial Units") {
                    Picker("Convert to", selection: $selectedUnitImperial) {
                        ForEach(unitsOfMeasurementImperial, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                }
                .foregroundColor(.blue)
                
                .onTapGesture {
                    self.amountIsFocused = false
                }
                
                Button {
                    convertedCapacity = capacityConversion(capacityFromUser)
                } label: {
                    Text("Convert")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .listRowBackground(Color.blue)
                .foregroundColor(.white)
                
                Section("Result") {
                    HStack {
                        Text("\(convertedCapacity, specifier: "%.3f")")
                        Spacer()
                        Divider()
                        Text(selectedUnitImperial)
                    }
                }
            }
            .navigationTitle("Capacity")
        }
    }
}

#Preview {
    CapacitySwiftUIView()
}

