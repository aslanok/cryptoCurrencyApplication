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
    
    func execute() {
        let urlString = "https://psp-merchantpanel-service-sandbox.ozanodeme.com.tr/api/v1/dummy/coins"
        guard let url = URL(string: urlString) else {
            output?.setFetchCoinDataFailed(error: "url hatası")
            return
        }
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if error == nil,let data = dataResponse, let resultData = try? JSONDecoder().decode(CryptoResponse.self, from: data) {
                self.output?.setFetchCoinDataSuccess(result: resultData)
            } else {
                self.output?.setFetchCoinDataFailed(error: error?.localizedDescription ?? "")
            }
        }.resume()
    }
    
    
}
