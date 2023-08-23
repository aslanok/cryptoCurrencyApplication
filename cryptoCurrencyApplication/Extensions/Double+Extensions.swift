//
//  Double+Extensions.swift
//  cryptoCurrencyApplication
//
//  Created by MacBook on 23.08.2023.
//

import Foundation

extension Double{
    func formatWithCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 3
        numberFormatter.maximumFractionDigits = 3
            
        if let formattedNumber = numberFormatter.string(from: NSNumber(value: self)) {
            return formattedNumber
        }
        return String(self)
    }
    
    func removeDecimalPart() -> String {
        return String(format: "%.0f", self)
    }
}
