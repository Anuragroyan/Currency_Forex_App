//
//  ContentView.swift
//  Currency_ForexApp
//
//  Created by Dungeon_master on 04/06/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var itemSelected1 = 0
    @State private var itemSelected2 = 1
    @State private var amount : String = ""
    
    private let currencies = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func convert(_ convert: String) -> String {
        var conversion: Double = 1.0
        let amount = Double(convert.doubleValue)
        let selectedCurrency1 = currencies[itemSelected1]
        let to = currencies[itemSelected2]
        
        let usdRates: [String: Double] = ["AUD": 0.71, "BRL": 5.44, "CAD": 1.34, "CNY": 6.77, "EUR": 0.89, "GBP": 0.77, "HKD": 7.80, "IDR": 14.000, "ILS": 3.60, "IN": 74.000, "JPY": 120.000, "MXN": 19.00, "NOK": 9.20, "NZD": 1.65, "PLN": 4.30, "RON": 4.40, "RUB": 77.00, "SEK": 10.00, "SGD": 1.44, "USD": 1.00, "ZAR": 17.00]
        let euroRates: [String: Double] = ["AUD": 1.14, "BRL": 6.00, "CAD": 1.49, "CNY": 7.50, "EUR": 1.00, "GBP": 0.82, "HKD": 8.40, "IDR": 14.500, "ILS": 3.70, "INR" : 79.000, "JPY": 130.000, "MXN": 21.00, "NOK": 9.40, "NZD": 1.70, "PLN": 4.40, "RON": 4.50, "RUB": 78.00, "SEK": 10.20, "SGD": 1.5  , "USD": 1.10, "ZAR": 17.50]
        let jpyRates: [String: Double] = ["AUD": 134.00, "BRL": 9.20, "CAD": 165.00, "CNY": 900.00, "EUR": 120.00, "GBP": 107.00, "HKD": 1070.00, "IDR": 13000, "ILS": 420.00, "INR": 12000, "JPY": 100.00, "MXN": 330.00, "NOK": 1100.00, "NZD": 190.00, "PLN": 460.00, "RON": 470.00, "RUB": 110, "SEK": 1120.00, "SGD": 180.00, "USD": 130.00, "ZAR": 1900.00]
        let gbpRates: [String: Double] = ["AUD": 1.43, "BRL": 6.50, "CAD": 1.65, "CNY": 8.20, "EUR": 0.90, "GBP": 1.00, "HKD": 9.30, "IDR": 14.800, "ILS": 3.80, "IN" : 77.000, "JPY": 127.000, "MXN": 23.00, "NOK": 9.60, "NZD": 1.75, "PLN": 4.50, "RON": 4.60, "RUB": 79.00, "SEK": 10.40, "SGD": 1.6, "USD": 1.20, "ZAR": 18.00]
        let audRates: [String: Double] = ["AUD": 1.00, "BRL": 5.20, "CAD": 1.30, "CNY": 6.50, "EUR": 0.80, "GBP": 0.70, "HKD": 7.60, "IDR": 13.800, "ILS": 3.50, "INR": 73.000, "JPY": 115.000, "MXN": 18.00, "NOK": 8.80, "NZD": 1.60, "PLN": 4.20, "RON": 4.30, "RUB": 76.00, "SEK": 9.80, "SGD": 1.45, "USD": 1.00, "ZAR": 16.00]
        let cadRates: [String: Double] = ["AUD": 1.35, "BRL": 5.70, "CAD": 1.00, "CNY": 6.20, "EUR": 0.75, "GBP": 0.65, "HKD": 7.30, "IDR": 13.400, "ILS": 3.40, "INR":  71.000, "JPY": 110.000, "MXN": 17.00, "NOK": 8.60, "NZD": 1.55, "PLN": 4.10, "RON": 4.20, "RUB": 75.00, "SEK": 9.60, "SGD": 1.40, "USD": 1.00, "ZAR": 15.00]
        let cnyRates: [String: Double] = ["AUD": 0.72, "BRL": 4.00, "CAD": 0.85, "CNY": 1.00, "EUR": 0.60, "GBP": 0.50, "HKD": 5.30, "IDR": 12.000, "ILS": 3.00, "IN": 67.000, "JPY": 83.000, "MXN": 15.00, "NOK": 7.40, "NZD": 0.90, "PLN": 3.80, "RON": 3.90, "RUB": 72.00, "SEK": 8.60, "SGD": 0.75, "USD": 0.65, "ZAR": 13.00]
        let inrRates: [String: Double] = ["AUD": 77.000, "BRL": 55.000, "CAD": 66.000, "CNY": 44.000, "EUR": 51.000, "GBP": 49.000, "HKD": 41.000, "IDR": 33.0, "ILS": 22.000, "INR": 1.00, "JPY": 8.300, "MXN": 40.000, "NOK": 32.000, "NZD": 64.000, "PLN": 30.000, "RON": 29.000, "RUB": 28.000, "SEK": 27.000, "SGD": 53.000, "USD": 76.000, "ZAR": 26.000]
        let brlRates: [String: Double] = ["AUD": 1.40, "BRL": 1.00, "CAD": 1.15, "CNY": 0.65, "EUR": 0.80, "GBP": 0.70, "HKD": 5.00, "IDR": 11.500, "ILS": 3.20, "IN": 68.000, "JPY": 85.000, "MXN": 16.00, "NOK": 7.80, "NZD": 1.05, "PLN": 3.95, "RON": 4.05, "RUB": 73.00, "SEK": 8.40, "SGD": 0.95, "USD": 1.00, "ZAR": 12.00]
        let zarRates: [String: Double] = ["AUD": 11.000, "BRL": 8.000, "CAD": 9.500, "CNY": 6.000, "EUR": 5.500, "GBP": 5.300, "HKD": 4.000, "IDR": 9.500, "ILS": 2.800, "IN": 56.000, "JPY": 7.200, "MXN": 35.000, "NOK": 26.000, "NZD": 12.500, "PLN": 23.000, "RON": 22.000, "RUB": 21.000, "SEK": 20.000, "SGD": 11.500, "USD": 9.000, "ZAR": 1.00]
        let HKDRates: [String: Double] = ["AUD": 0.14, "BRL": 0.70, "CAD": 0.16, "CNY": 0.01, "EUR": 0.01, "GBP": 0.01, "HKD": 1.00, "IDR": 10.000, "ILS": 0.28, "IN": 0.01, "JPY": 0.01, "MXN": 0.15, "NOK": 0.01, "NZD": 0.12, "PLN": 0.01, "RON": 0.01, "RUB": 0.01, "SEK": 0.01, "SGD": 0.14, "USD": 0.01, "ZAR": 0.01]
        let IDRRates: [String: Double] = ["AUD": 77.000, "BRL": 55.000, "CAD": 66.000, "CNY": 44.000, "EUR": 51.000, "GBP": 49.000, "HKD": 41.000, "IDR": 1.00, "ILS": 2, "INR": 1.00, "JPY": 8.300, "MXN": 40.000, "NOK": 32.000, "NZD": 64.000, "PLN": 30.000, "RON": 29.000, "RUB": 28.000, "SEK": 27.00, "SGD": 53.000, "USD": 76.000, "ZAR": 26.000]
        let ILSRates: [String: Double] = ["AUD": 3.200, "BRL": 2.100, "CAD": 3.400, "CNY": 2.000, "EUR": 1.900, "GBP": 1.800, "HKD": 1.600, "IDR": 1.800, "ILS": 1.00, "INR": 1.00, "JPY": 1.200, "MXN": 12.000, "NOK": 9.600, "NZD": 3.500, "PLN": 8.400, "RON": 8.300, "RUB": 8.200, "SEK": 8.100, "SGD": 3.300, "USD": 3.000, "ZAR": 1.00]
        let MXNRates: [String: Double] = ["AUD": 16.000, "BRL": 8.000, "CAD": 17.500, "CNY": 6.000, "EUR": 5.500, "GBP": 5.300, "HKD": 4.000, "IDR": 9.500, "ILS": 12.0, "INR": 68.000, "JPY": 7.200, "MXN": 1.00, "NOK": 26.000, "NZD": 12.500, "PLN": 23.000, "RON": 22.000, "RUB": 21.000, "SEK": 20.00, "SGD": 11.500, "USD": 9.000, "ZAR": 1.00]
        let NOKRates: [String: Double] = ["AUD": 0.09, "BRL": 0.60, "CAD": 0.11, "CNY": 0.01, "EUR": 0.01, "GBP": 0.01, "HKD": 0.01, "IDR": 0.01, "ILS": 0.01, "INR": 0.01, "JPY": 0.01, "MXN": 0.01, "NOK": 1.00, "NZD": 0.01, "PLN": 0.01, "RON": 0.01, "RUB": 0.01, "SEK": 0.01, "SGD": 0.01, "USD": 0.01, "ZAR": 0.01]
        let NZDRates: [String: Double] = ["AUD": 1.00, "BRL": 0.65, "CAD": 1.40, "CNY": 0.50, "EUR": 0.45, "GBP": 0.43, "HKD": 0.35, "IDR": 0.60, "ILS": 1.10, "INR": 0.58, "JPY": 0.40, "MXN": 0.25, "NOK": 0.80, "NZD": 1.00, "PLN": 0.70, "RON": 0.69, "RUB": 0.68, "SEK": 0.67, "SGD": 1.00, "USD": 0.90, "ZAR": 0.01]
        let PLNRates: [String: Double] = ["AUD": 0.04, "BRL": 0.30, "CAD": 0.05, "CNY": 0.01, "EUR": 0.01, "GBP": 0.01, "HKD": 0.01, "IDR": 0.01, "ILS": 0.01, "INR": 0.01, "JPY": 0.01, "MXN": 0.01, "NOK": 0.13, "NZD": 0.02, "PLN": 1.00, "RON": 0.01, "RUB": 0.01, "SEK": 0.01, "SGD": 0.01, "USD": 0.01, "ZAR": 0.01]
        let RONRates: [String: Double] = ["AUD": 0.05, "BRL": 0.35, "CAD": 0.07, "CNY": 0.01, "EUR": 0.01, "GBP": 0.01, "HKD": 0.01, "IDR": 0.01, "ILS": 0.01, "INR":   0.01, "JPY": 0.01, "MXN": 0.01, "NOK": 0.15, "NZD": 0.03, "PLN": 0.02, "RON": 1.00, "RUB": 0.01, "SEK": 0.01, "SGD": 0.01, "USD": 0.01, "ZAR": 0.01]
        let SEKRates: [String: Double] = ["AUD": 0.08, "BRL": 0.50, "CAD": 0.10, "CNY": 0.01, "EUR": 0.01, "GBP": 0.01, "HKD": 0.01, "IDR": 0.01, "ILS": 0.01, "INR": 0.01, "JPY": 0.01, "MXN": 0.01, "NOK": 0.20, "NZD": 0.01, "PLN": 0.01, "RON": 0.01, "RUB": 0.01, "SEK": 1.00, "SGD": 0.01, "USD": 0.01, "ZAR": 0.01]
        let SGDRates: [String: Double] = ["AUD": 1.00, "BRL": 0.65, "CAD": 1.40, "CNY": 0.50, "EUR": 0.45, "GBP": 0.43, "HKD": 0.35, "IDR": 0.60, "ILS": 1.10, "INR": 0.58, "JPY": 0.40, "MXN": 0.25, "NOK": 0.80, "NZD": 1.00, "PLN": 0.70, "RON": 0.69, "RUB": 0.68, "SEK": 0.67, "SGD": 1.00, "USD": 0.90, "ZAR": 0.01]
        let RUBRates: [String: Double] = ["AUD": 0.01, "BRL": 0.01, "CAD": 0.01, "CNY": 0.01, "EUR": 0.01, "GBP": 0.01, "HKD": 0.01, "IDR": 0.01, "ILS": 0.01, "INR": 0, "JPY": 0.01, "MXN": 0.01, "NOK": 0.01, "NZD": 0.01, "PLN": 0.01, "RON": 0.01, "RUB": 1.00, "SEK": 0.01, "SGD": 0.01, "USD": 0.01, "ZAR": 0.01]
        switch (selectedCurrency1) {
        case "USD" :
            conversion = amount * (usdRates[to] ?? 0.0)
        case "EUR" :
            conversion = amount * (euroRates[to] ?? 0.0)
        case "JPY" :
            conversion = amount * (jpyRates[to] ?? 0.0)
        case "GBP" :
            conversion = amount * (gbpRates[to] ?? 0.0)
        case "AUD" :
            conversion = amount * (audRates[to] ?? 0.0)
        case "CAD" :
             conversion = amount * (cadRates[to] ?? 0.0)
        case "CNY" :
            conversion = amount * (cnyRates[to] ?? 0.0)
        case "INR" :
            conversion = amount * (inrRates[to] ?? 0.0)
        case "BRL" :
            conversion = amount * (brlRates[to] ?? 0.0)
        case "ZAR" :
            conversion = amount * (zarRates[to] ?? 0.0)
        case "MXN" :
            conversion = amount * (MXNRates[to] ?? 0.0)
        case "ILS" :
            conversion = amount * (ILSRates[to] ?? 0.0)
        case "NOK" :
            conversion = amount * (NOKRates[to] ?? 0.0)
        case "HKD" :
            conversion = amount * (HKDRates[to] ?? 0.0)
        case "IDR" :
            conversion = amount * (IDRRates[to] ?? 0.0)
        case "NZD" :
            conversion = amount * (NZDRates[to] ?? 0.0)
        case "PLN" :
            conversion = amount * (PLNRates[to] ?? 0.0)
        case "RON" :
            conversion = amount * (RONRates[to] ?? 0.0)
        case "RUB" :
            conversion = amount * (RUBRates[to] ?? 0.0)
        case "SEK" :
            conversion = amount * (SEKRates[to] ?? 0.0)
        case "SGD":
            conversion = amount * (SGDRates[to] ?? 0.0)
        default:
            print("The currency you entered is not supported")
        }
        return String(format: "%.2f", conversion)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Convert A Currency")) {
                    TextField("Enter an amount", text: $amount).keyboardType(.decimalPad)
                    
                    Picker(selection: $itemSelected1, label: Text("From")) {
                        ForEach(0 ..< currencies.count) {index in Text(self.currencies[index]).tag(index)
                        }
                    }
                    
                    Picker(selection: $itemSelected2, label: Text("To")) {
                        ForEach(0 ..< currencies.count) {index in Text(self.currencies[index]).tag(index)
                        }
                    }
                }
                Section(header: Text("Conversion")){
                    Text("\(convert(amount)) \(currencies[itemSelected2])")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
