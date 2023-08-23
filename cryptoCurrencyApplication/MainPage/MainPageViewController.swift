//
//  ViewController.swift
//  cryptoCurrencyApplication
//
//  Created by MacBook on 22.08.2023.
//

import UIKit

protocol MainPageViewContract : UIViewController{
    func displayCoinData(result : [CoinDataModel])
}

class MainPageViewController: UIViewController, MainPageViewContract {
    
    private var coinDataList : [CoinDataModel] = [CoinDataModel]()
    var presenter : MainPagePresentation?
    private var filterList : [FilterOption] = FilterOption.allCases
    
    private lazy var rankingListLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ranking List"
        label.textColor = .Theme.navyBlueTextColor
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var sortingAreaBackgroundView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .Theme.openPurple
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var sortButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(filterList[0].rawValue, for: .normal)
        button.setTitleColor( UIColor.Theme.purpleTextColor, for: .normal)
        button.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var filtersTableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .Theme.openPurple
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(FilterTableViewCell.self, forCellReuseIdentifier: FilterTableViewCell.identifier)
        return tableView
    }()

    private lazy var rankingListTableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .Theme.viewBackgroundColor
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(RankingListTableViewCell.self, forCellReuseIdentifier: RankingListTableViewCell.identifier)
        return tableView
    }()
    
    override func loadView() {
        super.loadView()
        setupView()
        presenter?.fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rankingListTableView.delegate = self
        rankingListTableView.dataSource = self
        filtersTableView.dataSource = self
        filtersTableView.delegate = self
        filtersTableView.isHidden = true
    }

    func setupView(){
        view.backgroundColor = .Theme.viewBackgroundColor
        
        view.addSubview(rankingListLabel)
        rankingListLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        rankingListLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        view.addSubview(sortingAreaBackgroundView)
        sortingAreaBackgroundView.centerYAnchor.constraint(equalTo: rankingListLabel.centerYAnchor).isActive = true
        sortingAreaBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        sortingAreaBackgroundView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sortingAreaBackgroundView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        view.addSubview(sortButton)
        sortButton.centerYAnchor.constraint(equalTo: sortingAreaBackgroundView.centerYAnchor).isActive = true
        sortButton.centerXAnchor.constraint(equalTo: sortingAreaBackgroundView.centerXAnchor).isActive = true
        sortButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        sortButton.heightAnchor.constraint(equalToConstant: 30).isActive = true

        view.addSubview(rankingListTableView)
        rankingListTableView.topAnchor.constraint(equalTo: rankingListLabel.bottomAnchor, constant: 10).isActive = true
        rankingListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        rankingListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        rankingListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        
        view.addSubview(filtersTableView)
        filtersTableView.topAnchor.constraint(equalTo: sortButton.bottomAnchor, constant: 5).isActive = true
        filtersTableView.leadingAnchor.constraint(equalTo: sortingAreaBackgroundView.leadingAnchor).isActive = true
        filtersTableView.trailingAnchor.constraint(equalTo: sortingAreaBackgroundView.trailingAnchor).isActive = true
        filtersTableView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func displayCoinData(result: [CoinDataModel]) {
        coinDataList = result
        DispatchQueue.main.async {
            self.rankingListTableView.reloadData()
        }
    }

    @objc func sortButtonTapped(){
        if filtersTableView.isHidden {
            animate(toogle: true)
        } else {
            animate(toogle: false)
        }
    }

    func animate(toogle : Bool){
        if toogle {
            UIView.animate(withDuration: 0.3) {
                self.filtersTableView.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.filtersTableView.isHidden = true
            }
        }
    }
    
    func filterData(condition : FilterOption ){
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
        rankingListTableView.reloadData()
    }
    

}


extension MainPageViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == rankingListTableView {
            return 100
        } else if tableView == filtersTableView {
            return 40
        }
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == rankingListTableView {
            return coinDataList.count
        } else if tableView == filtersTableView {
            return filterList.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == rankingListTableView{
            if let cell = tableView.dequeueReusableCell(withIdentifier: RankingListTableViewCell.identifier) as? RankingListTableViewCell{
                cell.setupCell(coin: coinDataList[indexPath.row])
                return cell
            }
        } else if tableView == filtersTableView{
            if let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.identifier) as? FilterTableViewCell{
                cell.setupFilters(name: filterList[indexPath.row].rawValue)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == rankingListTableView {
            presenter?.openCoinDetail(coin : coinDataList[indexPath.row])
        } else if tableView == filtersTableView {
            sortButton.setTitle(filterList[indexPath.row].rawValue , for: .normal)
            filterData(condition: filterList[indexPath.row])
            sortButtonTapped()
        }
    }
    
    
}

