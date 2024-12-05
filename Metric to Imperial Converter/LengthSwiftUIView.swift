//
//  LengthSwiftUIView.swift
//  Metric to Imperial Converter
//
//  Created by Diana Dashinevich on 05/12/2024.
//

import SwiftUI

struct LengthSwiftUIView: View {
    @State private var lengthFromUser = 0.0
    @State private var selectedUnitMetric = "cm"
    @State private var selectedUnitImperial = "inch"
    @State private var convertedLength = 0.0
    
    
    let unitsOfMeasurementMetric = ["mm", "cm", "m", "km"]
    let unitsOfMeasurementImperial = ["inch", "foot", "yard", "mile"]
    
    func lengthConversion(_ length: Double) -> Double {
        var lengthInInches: Double
        switch selectedUnitMetric {
        case "mm":
            lengthInInches = length / 25.4
        case "cm":
            lengthInInches = length / 2.54
        case "m":
            lengthInInches = length * 39.37
        case "km":
            lengthInInches = length * 39370.1
        default:
            lengthInInches = length
        }
        
        switch selectedUnitImperial {
        case "inch":
            return lengthInInches
        case "foot":
            return lengthInInches / 12
        case "yard":
            return lengthInInches / 36
        case "mile":
            return lengthInInches / 63360
        default:
            return lengthInInches
        }
    }
    
    @FocusState private var amountIsFocused: Bool
    
    var body: some View {
        NavigationStack{
            Form {
                Section("Length in metric units") {
                    TextField("Amount", value: $lengthFromUser, format: .number
                    )
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    Picker("Units of measurement", selection: $selectedUnitMetric) {
                        ForEach(unitsOfMeasurementMetric, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                }
                .foregroundColor(.teal)
                
                Section("Lenght in Imperial Units") {
                    Picker("Convert to", selection: $selectedUnitImperial) {
                        ForEach(unitsOfMeasurementImperial, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                }
                .foregroundColor(.teal)
                
                .onTapGesture {
                    self.amountIsFocused = false
                }
                
                Button {
                    convertedLength = lengthConversion(lengthFromUser)
                } label: {
                    Text("Convert")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .listRowBackground(Color.teal)
                .foregroundColor(.white)
                
                
                Section("Result") {
                    HStack {
                        Text("\(convertedLength, specifier: "%.3f")")
                        Spacer()
                        Divider()
                        Text(selectedUnitImperial)
                    }
                }
            }
            .navigationTitle("Length")
        }
    }
}

#Preview {
    LengthSwiftUIView()
}
