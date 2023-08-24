//
//  NetworkingEnums.swift
//  cryptoCurrencyApplication
//
//  Created by MacBook on 24.08.2023.
//

import Foundation

enum NetworkError : Error{
    case urlError
    case cannotParseData
    case urlSessionError
    case dataFetchFailed
    
    var errorDescription : String{
        switch self{
        case .urlError:
            return "URL is not valid"
        case .cannotParseData:
            return "Data cannot parse"
        case .urlSessionError:
            return "url session didnt work"
        case .dataFetchFailed:
            return "data cannot fetched"
        default:
            return "unknown error"
        }
    }
}
