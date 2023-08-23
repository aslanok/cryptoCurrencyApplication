//
//  MainPagePresenter.swift
//  cryptoCurrencyApplication
//
//  Created by MacBook on 23.08.2023.
//

import Foundation

protocol MainPagePresentation{
    func fetchData()
    func openCoinDetail(coin : CoinDataModel)
}

class MainPagePresenter : MainPagePresentation, FetchCoinDataInteractorOutput{
    
    internal var output : MainPageViewContract!
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
    
    func setFetchCoinDataSuccess(result: CryptoResponse) {
        let modelledList = result.data.coins.map{ coin -> CoinDataModel in
            CoinDataModel(symbol: coin.symbol, name: coin.name, iconURL: coin.iconURL, price: coin.price, listedAt: coin.listedAt, change: coin.change, the24HVolume: coin.the24HVolume,marketCap: coin.marketCap, sparkLine: coin.sparkline)
        }
        output.displayCoinData(result: modelledList)
    }
    
    func setFetchCoinDataFailed(error: String) {
        
    }
    
    func openCoinDetail(coin: CoinDataModel) {
        router.presentDetailPage(from: output, coin: coin)
    }
    
    
}
