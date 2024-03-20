//
//  CurrencyFormatter.swift
//  ShopAtTBE
//
//  Created by Adnan Boxwala on 20.03.24.
//

import Foundation

//    Below currency formatter is still beta version
//    static let currencyFormat = FloatingPointFormatStyle<Double>.Currency(code: "AED", locale: Locale(identifier: "en_US"))

var currencyFormatter: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = "AED"
    formatter.maximumFractionDigits = 2
    formatter.groupingSeparator = "."
    formatter.usesGroupingSeparator = true
    return formatter
}
