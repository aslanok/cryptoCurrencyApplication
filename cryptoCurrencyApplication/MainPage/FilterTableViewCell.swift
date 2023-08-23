//
//  FilterTableViewCell.swift
//  cryptoCurrencyApplication
//
//  Created by MacBook on 23.08.2023.
//

import UIKit

class FilterTableViewCell : UITableViewCell{
    
    public static var identifier : String = "FilterTableViewCell"
    
    private lazy var filterNameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .Theme.purpleTextColor
        return label
    }()
    
    private lazy var cardView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .Theme.purpleTextColor
        //view.layer.cornerRadius = 8
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        contentView.backgroundColor = .Theme.openPurple
        contentView.addSubview(cardView)
        cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        contentView.addSubview(filterNameLabel)
        filterNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        filterNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        filterNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        /*
        contentView.addSubview(cardView)
        cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        cardView.addSubview(filterNameLabel)
        filterNameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 5).isActive = true
        filterNameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -5).isActive = true
        filterNameLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
         */
    }
    
    func setupFilters(name : String){
        filterNameLabel.text = name
    }
    
}
