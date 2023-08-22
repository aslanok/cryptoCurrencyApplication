//
//  DetailPagePresenter.swift
//  cryptoCurrencyApplication
//
//  Created by MacBook on 23.08.2023.
//

import Foundation

protocol DetailPagePresentation{
    func back()
}

class DetailPagePresenter : DetailPagePresentation{
    internal var output : DetailPageViewContract!
    private var router : DetailPageRouting
    
    init(router : DetailPageRouting, view : DetailPageViewContract){
        self.output = view
        self.router = router
    }
    
    func back() {
        router.back(from: output)
    }
    
}
