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
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.xAxis.drawLabelsEnabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        
        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.leftAxis.drawAxisLineEnabled = false
        chartView.leftAxis.drawLabelsEnabled = true
        chartView.leftAxis.labelCount = 3
        chartView.leftAxis.labelTextColor = .gray
        chartView.leftAxis.labelFont = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        chartView.rightAxis.drawGridLinesEnabled = false
        chartView.rightAxis.drawAxisLineEnabled = false
        chartView.rightAxis.drawLabelsEnabled = false
        
        let topLimitLine = ChartLimitLine(limit: 232)
        topLimitLine.lineColor = .lightGray
        topLimitLine.lineWidth = 1.0
        
        let middleLimitLine = ChartLimitLine(limit: 228)
        middleLimitLine.lineColor = .lightGray
        middleLimitLine.lineWidth = 1.0
                
        let bottomLimitLine = ChartLimitLine(limit: 224)
        bottomLimitLine.lineColor = .lightGray
        bottomLimitLine.lineWidth = 1.0
                
        chartView.leftAxis.addLimitLine(topLimitLine)
        chartView.leftAxis.addLimitLine(middleLimitLine)
        chartView.leftAxis.addLimitLine(bottomLimitLine)
        
        chartView.legend.enabled = false
        
        let marker = chartView.marker
        
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
        
        let dataEntries = createChartDataEntries(from: _coin.sparkline)
        let dataSet = LineChartDataSet(entries: dataEntries, label: "")
        dataSet.colors = [.Theme.successGreenColor]
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.mode = .horizontalBezier
        dataSet.lineWidth = 2.0
        dataSet.drawFilledEnabled = false
        dataSet.highlightColor = .lightGray
        
        let data = LineChartData(dataSet: dataSet)
        coinGraph.data = data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func backButtonTapped(){
        presenter?.back()
    }
    
    func createChartDataEntries(from values: [String]) -> [ChartDataEntry] {
        var entries: [ChartDataEntry] = []
        for (index, stringValue) in values.enumerated() {
            if let doubleValue = Double(stringValue) {
                let entry = ChartDataEntry(x: Double(index), y: doubleValue)
                entries.append(entry)
            }
        }
        return entries
    }
    
}
