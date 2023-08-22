//
//  ViewController.swift
//  cryptoCurrencyApplication
//
//  Created by MacBook on 22.08.2023.
//

import UIKit

protocol MainPageViewContract : UIViewController{
    func displayCoinData(result : CryptoModel)
}

class MainPageViewController: UIViewController, MainPageViewContract {
    
    private var coinDataList : [Coin] = [Coin]()
    var presenter : MainPagePresentation?
    
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
        // Do any additional setup after loading the view.
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
        
        view.addSubview(rankingListTableView)
        rankingListTableView.topAnchor.constraint(equalTo: rankingListLabel.bottomAnchor, constant: 10).isActive = true
        rankingListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        rankingListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        rankingListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        
    }
    
    func displayCoinData(result: CryptoModel) {
        coinDataList = result.data.coins
        DispatchQueue.main.async {
            self.rankingListTableView.reloadData()
        }
    }

    

}


extension MainPageViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coinDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: RankingListTableViewCell.identifier) as? RankingListTableViewCell{
            cell.setupCell(coin: coinDataList[indexPath.row])
            //cell.setupCell(viewModel: cellDataSource[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.openCoinDetail(coin : coinDataList[indexPath.row] )
    }
    
    
}

