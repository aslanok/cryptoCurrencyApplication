//
//  Enums.swift
//  cryptoCurrencyApplication
//
//  Created by MacBook on 24.08.2023.
//

import Foundation

enum FilterOption : String, CaseIterable{
    case marketCap = "MarketCap"
    case price = "Price"
    case volume24h = "24h Vol"
    case change = "Change"
    case listedAt = "ListedAt"
}

