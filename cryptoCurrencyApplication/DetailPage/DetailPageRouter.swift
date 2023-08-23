//
//  DetailPageRouter.swift
//  cryptoCurrencyApplication
//
//  Created by MacBook on 23.08.2023.
//

import Foundation
import UIKit

protocol DetailPageRouting{
    func back(from view : UIViewController?)
}

class DetailPageRouter : DetailPageRouting{
    
    func viewController(coin : Coin) -> UIViewController{
        let view = DetailPageViewController(coin: coin)
        let presenter = DetailPagePresenter(router: self, view: view)
        
        view.presenter = presenter
        presenter.output = view
        
        view.modalPresentationStyle = .fullScreen
        return view
    }
    
    func back(from view: UIViewController?) {
        view?.dismiss(animated: true)
    }
    
}
