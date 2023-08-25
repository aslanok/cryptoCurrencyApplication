//
//  MainPagePresenter.swift
//  cryptoCurrencyApplication
//
//  Created by MacBook on 23.08.2023.
//

import Foundation

protocol MainPagePresentation{
    func fetchData()
    func sortDataList(condition : SorterOption)
    func openCoinDetail(coin : CoinDataModel)
}

class MainPagePresenter : MainPagePresentation, FetchCoinDataInteractorOutput{
    
    internal var output : MainPageViewContract!
    private var router : MainPageRouting
    private var fetchCoinDataInteractor : FetchCoinDataInteractorInput
    private var coinDataList : [CoinDataModel] = [CoinDataModel]()
    
    init(router : MainPageRouting, view : MainPageViewContract, fetchCoinDataInteractor : FetchCoinDataInteractorInput){
        self.output = view
        self.router = router
        self.fetchCoinDataInteractor = fetchCoinDataInteractor
    }
    
    func fetchData() {
        output.showSpinner()
        fetchCoinDataInteractor.execute()
    }
    
    func setFetchCoinDataSuccess(result: CryptoResponse) {
        let modelledList = result.data.coins.map{ coin -> CoinDataModel in
            CoinDataModel(symbol: coin.symbol, name: coin.name, iconURL: coin.iconURL, price: coin.price, listedAt: coin.listedAt, change: coin.change, the24HVolume: coin.the24HVolume,marketCap: coin.marketCap, sparkLine: coin.sparkline)
        }
        coinDataList = modelledList
        output.displayCoinData(result: modelledList)
        output.removeLoading()
    }
    
    func setFetchCoinDataFailed(error: String) {
        output.removeLoading()
        print("Error handled")
    }
    
    func sortDataList(condition: SorterOption) {
        switch condition {
        case .volume24h:
            coinDataList = coinDataList.sorted(by: { coin1, coin2 in
                return coin1.getVolume24h() > coin2.getVolume24h()
            })
        case .price:
            coinDataList = coinDataList.sorted(by: { coin1, coin2 in
                return coin1.getPrice() > coin2.getPrice()
            })
        case .marketCap:
            coinDataList = coinDataList.sorted(by: { coin1, coin2 in
                return coin1.getMarketCap() > coin2.getMarketCap()
            })
        case .change:
            coinDataList = coinDataList.sorted(by: { coin1, coin2 in
                return coin1.getChange() > coin2.getChange()
            })
        case .listedAt:
            coinDataList = coinDataList.sorted(by: { coin1, coin2 in
                return coin1.listedAt < coin2.listedAt
            })
        }
        output.displaySortedData(result: coinDataList)
    }
    
    func openCoinDetail(coin: CoinDataModel) {
        router.presentDetailPage(from: output, coin: coin)
    }
    
    
}
