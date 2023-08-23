//
//  DetailPageViewController.swift
//  cryptoCurrencyApplication
//
//  Created by MacBook on 23.08.2023.
//

import UIKit
import Charts

protocol DetailPageViewContract : UIViewController{
    
}

class DetailPageViewController : UIViewController, DetailPageViewContract{
    
    var presenter : DetailPagePresentation?
    private var _coin : Coin
    
    private lazy var coinGraph : LineChartView = {
        let chartView = LineChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.leftAxis.drawGridLinesEnabled = false
        return chartView
    }()
    
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
    
    private lazy var currentPriceLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "CURRENT PRICE"
        label.textColor = .Theme.navyBlueTextColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private lazy var coinPriceLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = _coin.price
        label.textColor = .Theme.navyBlueTextColor
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var highLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "High:"
        label.textColor = .Theme.navyBlueTextColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private lazy var highPriceLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "62,903.21"
        label.textColor = .Theme.successGreenColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private lazy var lowLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Low:"
        label.textColor = .Theme.navyBlueTextColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private lazy var lowPriceLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "59,213.19"
        label.textColor = .Theme.failRedColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private lazy var coinChangePriceLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = _coin.change
        label.textColor = .Theme.successGreenColor
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    //highPrice ile highLabel'i birleştir
    
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
        
        view.addSubview(currentPriceLabel)
        currentPriceLabel.topAnchor.constraint(equalTo: fullNameTitleLabel.bottomAnchor, constant: 50).isActive = true
        currentPriceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        view.addSubview(coinPriceLabel)
        coinPriceLabel.topAnchor.constraint(equalTo: currentPriceLabel.bottomAnchor, constant: 10).isActive = true
        coinPriceLabel.leadingAnchor.constraint(equalTo: currentPriceLabel.leadingAnchor).isActive = true
        
        view.addSubview(coinChangePriceLabel)
        coinChangePriceLabel.topAnchor.constraint(equalTo: coinPriceLabel.bottomAnchor, constant: 10).isActive = true
        coinChangePriceLabel.leadingAnchor.constraint(equalTo: coinPriceLabel.leadingAnchor).isActive = true
        
        view.addSubview(highPriceLabel)
        highPriceLabel.topAnchor.constraint(equalTo: coinPriceLabel.centerYAnchor).isActive = true
        highPriceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        view.addSubview(highLabel)
        highLabel.topAnchor.constraint(equalTo: highPriceLabel.topAnchor).isActive = true
        highLabel.trailingAnchor.constraint(equalTo: highPriceLabel.leadingAnchor, constant: -5).isActive = true
        
        view.addSubview(lowPriceLabel)
        lowPriceLabel.topAnchor.constraint(equalTo: highPriceLabel.bottomAnchor, constant: 8).isActive = true
        lowPriceLabel.trailingAnchor.constraint(equalTo: highPriceLabel.trailingAnchor).isActive = true
        
        view.addSubview(lowLabel)
        lowLabel.topAnchor.constraint(equalTo: lowPriceLabel.topAnchor).isActive = true
        lowLabel.trailingAnchor.constraint(equalTo: lowPriceLabel.leadingAnchor, constant: -8).isActive = true
        
        view.addSubview(coinGraph)
        coinGraph.topAnchor.constraint(equalTo: coinChangePriceLabel.bottomAnchor, constant: 40).isActive = true
        coinGraph.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        coinGraph.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        coinGraph.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        let dataEntries: [ChartDataEntry] = [
                    // Create ChartDataEntry instances for each data point
                    // You can loop through your "sparkline" array and create entries here
                    // For simplicity, I'll create dummy entries here
                    ChartDataEntry(x: 1.0, y: 38.0497236257737307080000),
                    ChartDataEntry(x: 2.0, y: 38.1243298434867449000000),
                    ChartDataEntry(x: 3.0, y: 40),
                    ChartDataEntry(x: 4.0, y: 41),
                    ChartDataEntry(x: 5.0, y: 37),
                    ChartDataEntry(x: 6.0, y: 42),
                    ChartDataEntry(x: 7.0, y: 21)
                ]
                
        let dataSet = LineChartDataSet(entries: dataEntries, label: "Sparkline Data")
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.mode = .cubicBezier
        dataSet.lineWidth = 2.0
        dataSet.drawFilledEnabled = true
        
        let data = LineChartData(dataSet: dataSet)
        coinGraph.data = data

        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func backButtonTapped(){
        presenter?.back()
    }
    
    
    
}
