//
//  Validation.swift
//  OzFair
//
//  Created by Magnus Heilesen Andersen on 15/5/2023.
//

import SwiftUI

func nonNegativeNumber(text: inout String, newValue: String) {
    // Filter out non-numeric characters
    let filtered = newValue.filter { $0.isNumber || $0 == "." }
    text = filtered
    
    // Check if positive number
    if let number = Double(text), number < 0 {
        // If negative, reset input field
        text = ""
    }
}


func limitDecimalDigits(text: inout String, maxDigits: Int) {
    guard !text.isEmpty else { return }

    let components = text.components(separatedBy: ".")
    if components.count > 2 {
        // Remove extra dots
        let filtered = components.dropLast().joined(separator: "")
        text = filtered + "." + components.last!
    } else if components.count > 1, let decimalDigits = components.last {
        // Limit decimal digits
        if decimalDigits.count > maxDigits {
            text = String(text.prefix(text.count - (decimalDigits.count - maxDigits)))
        }
    }
}
