//
//  UIViewController+Extensions.swift
//  cryptoCurrencyApplication
//
//  Created by MacBook on 25.08.2023.
//

import Foundation
import UIKit

private let spinnerTag = 1907

extension UIViewController{
    
    func showSpinner() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            if let spinner = self.view.viewWithTag(spinnerTag) {
                spinner.removeFromSuperview()
            }
            let spinnerView = UIView.init(frame: self.view.bounds)
            spinnerView.tag = spinnerTag
            spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
            let activityIndicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
            activityIndicator.startAnimating()
            activityIndicator.center = spinnerView.center
            spinnerView.addSubview(activityIndicator)
            self.view.addSubview(spinnerView)
        }
    }
    
    func removeSpinner(){
        DispatchQueue.main.async { [weak self] in
            if let spinner = self?.view.viewWithTag(spinnerTag){
                spinner.removeFromSuperview()
            }
        }
    }
    
    
}
