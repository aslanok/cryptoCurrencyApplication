//
//  CoinDataModel.swift
//  cryptoCurrencyApplication
//
//  Created by MacBook on 23.08.2023.
//

import Foundation

class CoinDataModel{
    
    let symbol : String
    let name : String
    let iconURL : String
    let price : String
    let listedAt : Int
    let change : String
    let the24HVolume : String
    let sparkLine : [String]
    
    private var _sparkLineDouble : [Double] = [Double]()
    
    init(symbol : String, name : String, iconURL : String, price : String, listedAt : Int, change : String, the24HVolume : String, sparkLine : [String]){
        self.symbol = symbol
        self.name = name
        self.iconURL = iconURL
        self.price = price
        self.listedAt = listedAt
        self.change = change
        self.the24HVolume = the24HVolume
        self.sparkLine = sparkLine
        setSparkLineDouble()
    }
    
    func setSparkLineDouble(){
        sparkLine.forEach{ strValue in
            if let doubleValue = Double(strValue) {
                _sparkLineDouble.append(doubleValue)
            }
        }
    }
    
    func getSparkLineDouble() -> [Double] {
        return _sparkLineDouble
    }
    
    func getHighestSparkLine() -> Double {
        return _sparkLineDouble.max() ?? 0
    }
    
    func getLowestSparkLine() -> Double {
        return _sparkLineDouble.min() ?? 0
    }
    
    func getMiddleSparkLine() -> Double {
        return (getLowestSparkLine() + getHighestSparkLine())/2
    }
    
    func getIconImageURL() -> URL?{
        return URL(string: (self.iconURL.dropLast(3)+"png"))
    }
    
    func getFormattedPrice() -> String {
        return self.price.formatAsNumberWithCommas()
    }
    
    func getCalculatedChangedPrice() -> Double {
        return (Double(self.price) ?? 0.0) * (Double(self.change) ?? 0.0) / 100
    }
    
    func getChangePercentQuantity() -> String{
        if change.first == "-"{
            return "\(self.change)% (-$\(getCalculatedChangedPrice().magnitude.formatWithCommas()))"
        } else {
            return "\(self.change)% (+$\(getCalculatedChangedPrice().formatWithCommas()))"
        }
    }
    
}
