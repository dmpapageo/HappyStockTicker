//
//  StockCell.swift
//  HappyStockTicker
//
//  Created by Dimitrios Papageorgiou on 8/20/18.
//  Copyright © 2018 Dimitrios Papageorgiou. All rights reserved.
//

import UIKit

class StockCell: UITableViewCell {

    @IBOutlet weak var stockImageView: UIImageView!
    @IBOutlet weak var stockNameLabel: UILabel!
    
    func setStock(stock: Stock){
        stockImageView.image = stock.image
        stockNameLabel.text = stock.title
    }
    
    
    
}
