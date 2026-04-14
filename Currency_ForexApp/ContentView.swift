//
//  ContentView.swift
//  Currency_ForexApp
//
//  Redesigned with modern card UI + dark/light mode toggle
//

import SwiftUI

struct ContentView: View {

    @State private var itemSelected1 = 19   // USD
    @State private var itemSelected2 = 9    // INR
    @State private var amount: String = "1000"
    @AppStorage("isDarkMode") private var isDarkMode: Bool = true

    private let currencies: [(code: String, name: String, flag: String)] = [
        ("AUD", "Australian Dollar", "🇦🇺"),
        ("BRL", "Brazilian Real",    "🇧🇷"),
        ("CAD", "Canadian Dollar",   "🇨🇦"),
        ("CNY", "Chinese Yuan",      "🇨🇳"),
        ("EUR", "Euro",              "🇪🇺"),
        ("GBP", "British Pound",     "🇬🇧"),
        ("HKD", "Hong Kong Dollar",  "🇭🇰"),
        ("IDR", "Indonesian Rupiah", "🇮🇩"),
        ("ILS", "Israeli Shekel",    "🇮🇱"),
        ("INR", "Indian Rupee",      "🇮🇳"),
        ("JPY", "Japanese Yen",      "🇯🇵"),
        ("MXN", "Mexican Peso",      "🇲🇽"),
        ("NOK", "Norwegian Krone",   "🇳🇴"),
        ("NZD", "New Zealand Dollar","🇳🇿"),
        ("PLN", "Polish Złoty",      "🇵🇱"),
        ("RON", "Romanian Leu",      "🇷🇴"),
        ("RUB", "Russian Ruble",     "🇷🇺"),
        ("SEK", "Swedish Krona",     "🇸🇪"),
        ("SGD", "Singapore Dollar",  "🇸🇬"),
        ("USD", "US Dollar",         "🇺🇸"),
        ("ZAR", "South African Rand","🇿🇦")
    ]

    private let usdRates: [String: Double] = [
        "AUD":0.65,"BRL":5.44,"CAD":1.36,"CNY":7.24,"EUR":0.92,
        "GBP":0.79,"HKD":7.83,"IDR":15700,"ILS":3.71,"INR":83.12,
        "JPY":151.4,"MXN":17.15,"NOK":10.55,"NZD":1.63,"PLN":4.02,
        "RON":4.57,"RUB":91.50,"SEK":10.42,"SGD":1.35,"USD":1.00,"ZAR":18.63
    ]

    func convert() -> String {
        let fromCode = currencies[itemSelected1].code
        let toCode   = currencies[itemSelected2].code
        guard let fromRate = usdRates[fromCode],
              let toRate   = usdRates[toCode],
              let inputAmount = Double(amount.replacingOccurrences(of: ",", with: "")),
              fromRate > 0
        else { return "–" }
        let usdValue  = inputAmount / fromRate
        let converted = usdValue * toRate
        return String(format: converted >= 1000 ? "%.0f" : "%.2f", converted)
    }

    func unitRate() -> String {
        let fromCode = currencies[itemSelected1].code
        let toCode   = currencies[itemSelected2].code
        guard let fromRate = usdRates[fromCode],
              let toRate   = usdRates[toCode],
              fromRate > 0
        else { return "–" }
        let rate = toRate / fromRate
        return String(format: rate >= 100 ? "%.0f" : "%.4f", rate)
    }

    var body: some View {
        let bg    = isDarkMode ? Color(hex: "0F0F10") : Color(hex: "F2F2F7")
        let card  = isDarkMode ? Color(hex: "1C1C1E") : Color.white
        let label = isDarkMode ? Color(hex: "8E8E93") : Color(hex: "6E6E73")
        let text  = isDarkMode ? Color.white          : Color.black

        ZStack {
            bg.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {

                    // ── Navigation bar ──────────────────────────────
                    HStack {
                        Text("Forex")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(text)
                        Spacer()
                        // Dark / Light toggle
                        Button {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                isDarkMode.toggle()
                            }
                        } label: {
                            ZStack(alignment: isDarkMode ? .trailing : .leading) {
                                Capsule()
                                    .fill(isDarkMode ? Color(hex: "30D158") : Color(hex: "E9E9EB"))
                                    .frame(width: 50, height: 28)
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 22, height: 22)
                                    .overlay(
                                        Text(isDarkMode ? "🌙" : "☀️")
                                            .font(.system(size: 12))
                                    )
                                    .padding(3)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 12)

                    // ── "You Send" card ─────────────────────────────
                    VStack(alignment: .leading, spacing: 8) {
                        Text("YOU SEND")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundColor(label)
                            .kerning(0.5)

                        TextField("0", text: $amount)
                            .font(.system(size: 36, weight: .light))
                            .foregroundColor(text)
                            .keyboardType(.decimalPad)

                        Divider().background(label.opacity(0.25))

                        currencyPickerRow(
                            index: $itemSelected1,
                            card: card, label: label, text: text
                        )
                    }
                    .padding(16)
                    .background(card)
                    .cornerRadius(16)
                    .padding(.horizontal, 16)

                    // ── Swap button ──────────────────────────────────
                    Button {
                        withAnimation(.spring()) {
                            let tmp = itemSelected1
                            itemSelected1 = itemSelected2
                            itemSelected2 = tmp
                        }
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(text)
                            .frame(width: 44, height: 44)
                            .background(card)
                            .clipShape(Circle())
                    }
                    .padding(.vertical, 10)

                    // ── "They Receive" card ─────────────────────────
                    VStack(alignment: .leading, spacing: 8) {
                        Text("THEY RECEIVE")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundColor(label)
                            .kerning(0.5)

                        Text(convert())
                            .font(.system(size: 36, weight: .light))
                            .foregroundColor(text)

                        Divider().background(label.opacity(0.25))

                        currencyPickerRow(
                            index: $itemSelected2,
                            card: card, label: label, text: text
                        )
                    }
                    .padding(16)
                    .background(card)
                    .cornerRadius(16)
                    .padding(.horizontal, 16)

                    // ── Rate badge ──────────────────────────────────
                    HStack {
                        Text("1 \(currencies[itemSelected1].code) = ")
                            .foregroundColor(label)
                        Text("\(unitRate()) \(currencies[itemSelected2].code)")
                            .foregroundColor(Color(hex: "30D158"))
                    }
                    .font(.system(size: 13, weight: .medium))
                    .padding(12)
                    .background(card)
                    .cornerRadius(12)
                    .padding(.horizontal, 16)
                    .padding(.top, 10)

                    // ── Quick amounts ────────────────────────────────
                    VStack(alignment: .leading, spacing: 8) {
                        Text("QUICK AMOUNTS")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundColor(label)
                            .kerning(0.5)
                            .padding(.horizontal, 4)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(["100","500","1,000","5,000","10,000"], id: \.self) { val in
                                    Button {
                                        amount = val
                                    } label: {
                                        Text(val)
                                            .font(.system(size: 13, weight: .medium))
                                            .padding(.horizontal, 14)
                                            .padding(.vertical, 7)
                                            .background(
                                                amount == val
                                                    ? Color(hex: "0A84FF")
                                                    : (isDarkMode ? Color(hex: "2C2C2E") : Color(hex: "E5E5EA"))
                                            )
                                            .foregroundColor(amount == val ? .white : text)
                                            .cornerRadius(20)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal, 4)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 20)

                    // ── Popular rates ────────────────────────────────
                    VStack(alignment: .leading, spacing: 0) {
                        Text("POPULAR RATES")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundColor(label)
                            .kerning(0.5)
                            .padding(.bottom, 8)
                            .padding(.horizontal, 4)

                        VStack(spacing: 0) {
                            ForEach(["EUR","GBP","JPY","CAD","AUD","CNY"], id: \.self) { code in
                                if let entry = currencies.first(where: { $0.code == code }),
                                   let rate  = usdRates[code] {
                                    HStack {
                                        Text(entry.flag)
                                            .font(.system(size: 22))
                                            .frame(width: 36, height: 36)
                                            .background(isDarkMode ? Color(hex:"2C2C2E") : Color(hex:"F2F2F7"))
                                            .clipShape(Circle())

                                        VStack(alignment: .leading, spacing: 1) {
                                            Text(entry.code)
                                                .font(.system(size: 15, weight: .semibold))
                                                .foregroundColor(text)
                                            Text(entry.name)
                                                .font(.system(size: 11))
                                                .foregroundColor(label)
                                        }
                                        .padding(.leading, 8)

                                        Spacer()

                                        Text(String(format: rate > 10 ? "%.2f" : "%.4f", rate))
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(text)
                                    }
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 14)

                                    if code != "CNY" {
                                        Divider()
                                            .background(label.opacity(0.2))
                                            .padding(.leading, 58)
                                    }
                                }
                            }
                        }
                        .background(card)
                        .cornerRadius(16)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                    .padding(.bottom, 32)
                }
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }

    // ── Currency picker row ──────────────────────────────────────────
    @ViewBuilder
    func currencyPickerRow(
        index: Binding<Int>,
        card: Color, label: Color, text: Color
    ) -> some View {
        HStack {
            Text(currencies[index.wrappedValue].flag)
                .font(.system(size: 22))
                .frame(width: 36, height: 36)
                .background(label.opacity(0.15))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text(currencies[index.wrappedValue].code)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(text)
                Text(currencies[index.wrappedValue].name)
                    .font(.system(size: 12))
                    .foregroundColor(label)
            }
            .padding(.leading, 6)

            Spacer()

            Picker("", selection: index) {
                ForEach(0 ..< currencies.count, id: \.self) { i in
                    Text("\(currencies[i].flag) \(currencies[i].code)").tag(i)
                }
            }
            .pickerStyle(.menu)
            .foregroundColor(Color(hex: "0A84FF"))
        }
    }
}

// ── Color hex helper ─────────────────────────────────────────────────
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >>  8) & 0xFF) / 255
        let b = Double( int        & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}

#Preview {
    ContentView()
}
