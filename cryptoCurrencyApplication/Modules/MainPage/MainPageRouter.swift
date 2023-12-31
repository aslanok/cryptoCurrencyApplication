//
//  MainPageRouter.swift
//  cryptoCurrencyApplication
//
//  Created by MacBook on 23.08.2023.
//

import UIKit
import SwiftUI

protocol MainPageRouting{
    func presentDetailPage(from view : UIViewController?, coin : CoinDataModel)
}

class MainPageRouter : MainPageRouting{
    
    var viewController : UIViewController {
        let view = MainPageViewController()
        let fetchCryptoInteractor = FetchCoinDataInteractor()
        let presenter = MainPagePresenter(router: self, view: view, fetchCoinDataInteractor: fetchCryptoInteractor)
        
        fetchCryptoInteractor.output = presenter
        view.presenter = presenter
        presenter.output = view
        return view
    }
    
    func presentDetailPage(from view: UIViewController?, coin : CoinDataModel) {
        let router = DetailPageRouter()
        view?.present(router.viewController(coin: coin), animated: true)
    }
    
    
}
