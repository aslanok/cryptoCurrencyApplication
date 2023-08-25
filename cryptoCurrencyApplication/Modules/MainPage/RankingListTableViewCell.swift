//
//  RankingListTableViewCell.swift
//  cryptoPosApp
//
//  Created by MacBook on 22.08.2023.
//

import UIKit
import SDWebImage

class RankingListTableViewCell : UITableViewCell {
    
    public static var identifier : String {
        return "RankingListTableViewCell"
    }
    
    private lazy var cardView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var assetImage : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var assetName : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .Theme.grayTextColor
        label.text = "ETH"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var assetFullName : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ethereum"
        label.textColor = .Theme.navyBlueTextColor
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var assetPriceLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .Theme.navyBlueTextColor
        label.text = "$2,147.53"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var assetPriceChangeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .Theme.successGreenColor
        label.text = "+0.02% (+$0.243)"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        contentView.backgroundColor = .Theme.viewBackgroundColor
        contentView.addSubview(cardView)
        cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        
        cardView.addSubview(assetImage)
        assetImage.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
        assetImage.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        assetImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        assetImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        cardView.addSubview(assetName)
        assetName.bottomAnchor.constraint(equalTo: cardView.centerYAnchor, constant: -6).isActive = true
        assetName.leadingAnchor.constraint(equalTo: assetImage.trailingAnchor, constant: 10).isActive = true

        cardView.addSubview(assetFullName)
        assetFullName.topAnchor.constraint(equalTo: cardView.centerYAnchor, constant: 6).isActive = true
        assetFullName.leadingAnchor.constraint(equalTo: assetName.leadingAnchor).isActive = true
        assetFullName.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        cardView.addSubview(assetPriceLabel)
        assetPriceLabel.bottomAnchor.constraint(equalTo: cardView.centerYAnchor, constant: -5).isActive = true
        assetPriceLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -5).isActive = true
        
        cardView.addSubview(assetPriceChangeLabel)
        assetPriceChangeLabel.topAnchor.constraint(equalTo: cardView.centerYAnchor, constant: 5).isActive = true
        assetPriceChangeLabel.trailingAnchor.constraint(equalTo: assetPriceLabel.trailingAnchor).isActive = true
        
    }
    
    func setupCell(coin : CoinDataModel){
        self.assetImage.sd_setImage(with: coin.getIconImageURL())
        self.assetName.text = coin.symbol
        self.assetFullName.text = coin.name
        self.assetPriceLabel.text = "$"+coin.getFormattedPrice()
        if coin.change.first == "-"{
            assetPriceChangeLabel.textColor = .Theme.failRedColor
        } else {
            assetPriceChangeLabel.textColor = .Theme.successGreenColor
        }
        assetPriceChangeLabel.text = coin.getChangePercentQuantity()
    }

}
