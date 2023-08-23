//
//  String+Extensions.swift
//  cryptoCurrencyApplication
//
//  Created by MacBook on 23.08.2023.
//

import Foundation

extension String {
    
    func formatAsNumberWithCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 3
        numberFormatter.maximumFractionDigits = 3
        if let number = Double(self),
            let formattedNumber = numberFormatter.string(from: NSNumber(value: number)) {
            return formattedNumber
        }
        return ""
    }

    
}
