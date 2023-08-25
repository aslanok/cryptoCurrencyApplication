//
//  ViewController.swift
//  cryptoCurrencyApplication
//
//  Created by MacBook on 22.08.2023.
//

import UIKit

protocol MainPageViewContract : UIViewController{
    func displayCoinData(result : [CoinDataModel])
    func displaySortedData(result : [CoinDataModel])
    func showLoading()
    func removeLoading()
}

class MainPageViewController: UIViewController, MainPageViewContract {
    
    var presenter : MainPagePresentation?
    
    private var coinDataList : [CoinDataModel] = [CoinDataModel]()
    private var sorterList : [SorterOption] = SorterOption.allCases
    
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
        button.setTitle(sorterList[0].rawValue, for: .normal)
        button.setTitleColor( UIColor.Theme.purpleTextColor, for: .normal)
        button.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var sortersTableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .Theme.openPurple
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(SorterTableViewCell.self, forCellReuseIdentifier: SorterTableViewCell.identifier)
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
        sortersTableView.dataSource = self
        sortersTableView.delegate = self
        sortersTableView.isHidden = true
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
        
        view.addSubview(sortersTableView)
        sortersTableView.topAnchor.constraint(equalTo: sortButton.bottomAnchor, constant: 5).isActive = true
        sortersTableView.leadingAnchor.constraint(equalTo: sortingAreaBackgroundView.leadingAnchor).isActive = true
        sortersTableView.trailingAnchor.constraint(equalTo: sortingAreaBackgroundView.trailingAnchor).isActive = true
        sortersTableView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func showLoading() {
        self.showSpinner()
    }
    
    func removeLoading() {
        self.removeSpinner()
    }
    
    func displayCoinData(result: [CoinDataModel]) {
        coinDataList = result
        DispatchQueue.main.async {
            self.rankingListTableView.reloadData()
        }
    }

    @objc func sortButtonTapped(){
        if sortersTableView.isHidden {
            animate(toogle: true)
        } else {
            animate(toogle: false)
        }
    }

    func animate(toogle : Bool){
        if toogle {
            UIView.animate(withDuration: 0.3) {
                self.sortersTableView.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.sortersTableView.isHidden = true
            }
        }
    }
    
    func displaySortedData(result: [CoinDataModel]) {
        self.coinDataList = result
        rankingListTableView.reloadData()
    }

}


extension MainPageViewController : UITableViewDelegate, UITableViewDataSource {
    
    // we have 2 tableViews in that view. Because of that in all tableView methods we have to check tableView.
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == rankingListTableView {
            return 100
        } else if tableView == sortersTableView {
            return 40
        }
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == rankingListTableView {
            return coinDataList.count
        } else if tableView == sortersTableView {
            return sorterList.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == rankingListTableView{
            if let cell = tableView.dequeueReusableCell(withIdentifier: RankingListTableViewCell.identifier) as? RankingListTableViewCell{
                cell.setupCell(coin: coinDataList[indexPath.row])
                return cell
            }
        } else if tableView == sortersTableView{
            if let cell = tableView.dequeueReusableCell(withIdentifier: SorterTableViewCell.identifier) as? SorterTableViewCell{
                cell.setupSorter(name: sorterList[indexPath.row].rawValue)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == rankingListTableView {
            presenter?.openCoinDetail(coin : coinDataList[indexPath.row])
        } else if tableView == sortersTableView {
            sortButton.setTitle(sorterList[indexPath.row].rawValue , for: .normal)
            presenter?.sortDataList(condition: sorterList[indexPath.row])
            sortButtonTapped()
        }
    }
    
    
}

