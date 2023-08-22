//
//  MainPagePresenter.swift
//  cryptoCurrencyApplication
//
//  Created by MacBook on 23.08.2023.
//

import Foundation

protocol MainPagePresentation{
    func fetchData()
}

class MainPagePresenter : MainPagePresentation, FetchCoinDataInteractorOutput{
    
    internal var output : MainPageViewContract
    private var router : MainPageRouting
    private var fetchCoinDataInteractor : FetchCoinDataInteractorInput
    
    init(router : MainPageRouting, view : MainPageViewContract, fetchCoinDataInteractor : FetchCoinDataInteractorInput){
        self.output = view
        self.router = router
        self.fetchCoinDataInteractor = fetchCoinDataInteractor
    }
    
    func fetchData() {
        fetchCoinDataInteractor.execute()
    }
    
    func setFetchCoinDataSuccess(result: CryptoModel) {
        output.displayCoinData(result: result)
    }
    
    func setFetchCoinDataFailed(error: String) {
        
    }
    
    
}
