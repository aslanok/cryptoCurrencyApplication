//
//  DetailPageViewController.swift
//  cryptoCurrencyApplication
//
//  Created by MacBook on 23.08.2023.
//

import UIKit

protocol DetailPageViewContract : UIViewController{
    
}

class DetailPageViewController : UIViewController, DetailPageViewContract{
    
    var presenter : DetailPagePresentation?
    private var _coin : Coin
    
    private lazy var nameTitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = _coin.symbol
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .Theme.grayTextColor
        return label
    }()
    
    private lazy var fullNameTitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = _coin.name
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .Theme.navyBlueTextColor
        return label
    }()
    
    private lazy var backButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(coin : Coin){
        self._coin = coin
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .Theme.viewBackgroundColor
        
        view.addSubview(backButton)
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(nameTitleLabel)
        nameTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        nameTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(fullNameTitleLabel)
        fullNameTitleLabel.topAnchor.constraint(equalTo: nameTitleLabel.bottomAnchor, constant: 10).isActive = true
        fullNameTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func backButtonTapped(){
        presenter?.back()
    }
    
    
    
}
