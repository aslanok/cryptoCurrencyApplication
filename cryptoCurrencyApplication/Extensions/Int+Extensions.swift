//
//  Int+Extensions.swift
//  cryptoCurrencyApplication
//
//  Created by MacBook on 25.08.2023.
//

import Foundation

extension Int {
    func toDateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(self)))
    }
}
