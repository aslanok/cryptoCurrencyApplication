//
//  FilterTableViewCell.swift
//  cryptoCurrencyApplication
//
//  Created by MacBook on 23.08.2023.
//

import UIKit

class SorterTableViewCell : UITableViewCell{

    public static var identifier : String = "SorterTableViewCell"

    private lazy var sorterNameLabel : UILabel = {
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
        
        contentView.addSubview(sorterNameLabel)
        sorterNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        sorterNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        sorterNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    func setupSorter(name : String){
        sorterNameLabel.text = name
    }
    
}
