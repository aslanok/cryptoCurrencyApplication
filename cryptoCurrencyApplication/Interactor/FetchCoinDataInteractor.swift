//
//  FetchCoinDataInteractor.swift
//  cryptoCurrencyApplication
//
//  Created by MacBook on 23.08.2023.
//

import Foundation

protocol FetchCoinDataInteractorInput{
    func execute()
}

protocol FetchCoinDataInteractorOutput{
    func setFetchCoinDataSuccess(result : CryptoResponse)
    func setFetchCoinDataFailed(error : String)
}

class FetchCoinDataInteractor : FetchCoinDataInteractorInput{
    
    internal var output : FetchCoinDataInteractorOutput?
    
    let endpointURL = "https://psp-merchantpanel-service-sandbox.ozanodeme.com.tr/api/v1/dummy/coins"
    func execute() {
        APIService.shared.request( endpointURL, type: CryptoResponse.self) { result in
            switch result{
            case .success(let data):
                self.output?.setFetchCoinDataSuccess(result: data)
            case .failure(let error):
                self.output?.setFetchCoinDataFailed(error: error.errorDescription)
            }
        }
    }
    
    
}
