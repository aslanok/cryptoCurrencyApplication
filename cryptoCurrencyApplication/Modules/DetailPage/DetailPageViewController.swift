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
    private var _coin : CoinDataModel
    private var dataEntries : [ChartDataEntry] = [ChartDataEntry]()
    private var dataSet = LineChartDataSet()
    
    private lazy var coinGraph : LineChartView = {
        let chartView = LineChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.xAxis.drawLabelsEnabled = false
        chartView.xAxis.drawGridLinesEnabled = false

        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.leftAxis.drawAxisLineEnabled = false
        chartView.leftAxis.drawLabelsEnabled = false
        chartView.leftAxis.labelCount = 3
        chartView.leftAxis.labelTextColor = .gray
        chartView.leftAxis.labelFont = UIFont.systemFont(ofSize: 14, weight: .medium)

        chartView.rightAxis.drawGridLinesEnabled = false
        chartView.rightAxis.drawAxisLineEnabled = false
        chartView.rightAxis.drawLabelsEnabled = false

        let topLimitLine = ChartLimitLine(limit: _coin.getHighestSparkLine())
        topLimitLine.lineColor = .lightGray
        topLimitLine.lineWidth = 1.0

        let middleLimitLine = ChartLimitLine(limit: _coin.getMiddleSparkLine())
        middleLimitLine.lineColor = .lightGray
        middleLimitLine.lineWidth = 1.0

        let bottomLimitLine = ChartLimitLine(limit: _coin.getLowestSparkLine())
        bottomLimitLine.lineColor = .lightGray
        bottomLimitLine.lineWidth = 1.0

        chartView.leftAxis.addLimitLine(topLimitLine)
        chartView.leftAxis.addLimitLine(middleLimitLine)
        chartView.leftAxis.addLimitLine(bottomLimitLine)

        chartView.legend.enabled = false
        chartView.isUserInteractionEnabled = false
        
        dataEntries = createChartDataEntries(from: _coin.getSparkLineDouble())
        dataSet = LineChartDataSet(entries: dataEntries)
        dataSet.colors = [.Theme.successGreenColor]
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.mode = .horizontalBezier
        dataSet.lineWidth = 2.0
        dataSet.drawFilledEnabled = false

        // The options below are choices for filling under the graph's line.

        //dataSet.drawFilledEnabled = true
        //dataSet.fillColor = .Theme.successGreenColor
        //dataSet.highlightColor = .lightGray
        dataSet.highlightEnabled = false
        
        let data = LineChartData(dataSet: dataSet)
        chartView.data = data
        chartView.animate(xAxisDuration: 0.8)
        
        return chartView
    }()
    
    private lazy var nameTitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = _coin.symbol
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .Theme.grayTextColor
        return label
    }()
    
    private lazy var fullNameTitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = _coin.name
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
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
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var coinPriceLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = _coin.price
        label.textColor = .Theme.navyBlueTextColor
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private lazy var highLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "High:"
        label.textColor = .Theme.navyBlueTextColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var highPriceLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "62,903.21"
        label.textColor = .Theme.successGreenColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var lowLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Low:"
        label.textColor = .Theme.navyBlueTextColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var lowPriceLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "59,213.19"
        label.textColor = .Theme.failRedColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var coinChangePriceLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = _coin.change
        label.textColor = .Theme.successGreenColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var leftTopLimitGraphLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$" + _coin.getHighestSparkLine().formatWithCommas()
        label.textColor = .Theme.grayTextColor
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var leftMidLimitGraphLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$" + _coin.getMiddleSparkLine().formatWithCommas()
        label.textColor = .Theme.grayTextColor
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var leftBottomLimitGraphLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$" + _coin.getLowestSparkLine().formatWithCommas()
        label.textColor = .Theme.grayTextColor
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    
    private lazy var listedDateLable : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Listed At: \(_coin.getDate())"
        label.textColor = .Theme.navyBlueTextColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    init(coin : CoinDataModel){
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
        
        view.addSubview(listedDateLable)
        listedDateLable.centerYAnchor.constraint(equalTo: currentPriceLabel.centerYAnchor).isActive = true
        listedDateLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
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
        coinGraph.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60).isActive = true
        coinGraph.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        coinGraph.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        view.addSubview(leftTopLimitGraphLabel)
        leftTopLimitGraphLabel.topAnchor.constraint(equalTo: coinGraph.topAnchor, constant: 20).isActive = true
        leftTopLimitGraphLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        leftTopLimitGraphLabel.trailingAnchor.constraint(equalTo: coinGraph.leadingAnchor, constant: -3).isActive = true
        
        view.addSubview(leftMidLimitGraphLabel)
        leftMidLimitGraphLabel.centerYAnchor.constraint(equalTo: coinGraph.centerYAnchor).isActive = true
        leftMidLimitGraphLabel.leadingAnchor.constraint(equalTo: leftTopLimitGraphLabel.leadingAnchor).isActive = true
        leftMidLimitGraphLabel.trailingAnchor.constraint(equalTo: leftTopLimitGraphLabel.trailingAnchor).isActive = true
        
        view.addSubview(leftBottomLimitGraphLabel)
        leftBottomLimitGraphLabel.topAnchor.constraint(equalTo: coinGraph.bottomAnchor, constant: -35).isActive = true
        leftBottomLimitGraphLabel.leadingAnchor.constraint(equalTo: leftTopLimitGraphLabel.leadingAnchor).isActive = true
        leftBottomLimitGraphLabel.trailingAnchor.constraint(equalTo: leftTopLimitGraphLabel.trailingAnchor).isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDatas()
    }
    
    @objc func backButtonTapped(){
        presenter?.back()
    }
    
    func setUpDatas(){
        coinPriceLabel.text = "$"+self._coin.getFormattedPrice()
        highPriceLabel.text = _coin.getHighestSparkLine().formatWithCommas()
        lowPriceLabel.text = _coin.getLowestSparkLine().formatWithCommas()
        coinChangePriceLabel.text = _coin.getChangePercentQuantity()
        
        if _coin.change.first == "-"{
            coinChangePriceLabel.textColor = .Theme.failRedColor
            dataSet.colors = [.Theme.failRedColor]
        }

        if highPriceLabel.text?.count ?? 0 > 6 {
            leftTopLimitGraphLabel.text = "$" + _coin.getHighestSparkLine().removeDecimalPart()
            leftBottomLimitGraphLabel.text = "$" + _coin.getLowestSparkLine().removeDecimalPart()
            leftMidLimitGraphLabel.text = "$" + _coin.getMiddleSparkLine().removeDecimalPart()
        }

    }
    
    func createChartDataEntries(from values: [Double]) -> [ChartDataEntry] {
        var entries: [ChartDataEntry] = []
        for (index, value) in values.enumerated() {
            let entry = ChartDataEntry(x: Double(index), y: value)
            entries.append(entry)
        }
        return entries
    }
    
}
