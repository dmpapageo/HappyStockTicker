//
//  StockListScreen.swift
//  HappyStockTicker
//
//  Created by Dimitrios Papageorgiou on 8/17/18.
//  Copyright © 2018 Dimitrios Papageorgiou. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class StockListScreen: UIViewController {

    //my Key for Alpha Vantage
    let APIKEY = "APIKEY";
    let DEMOstockURL = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=MSFT&outputsize=full&apikey=demo";
    let amazonStockURL = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=AMZN&outputsize=full&apikey=APIKEY";
    
    
    //url components
    let headURL = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=";
    let stockSymbol = ["SPX", "GOOGL", "MSFT", "FB", "TSLA"];
    let tailURL = "&outputsize=full&apikey=APIKEY";

    
    @IBOutlet weak var tableView: UITableView!

    var stocks: [Stock] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        stocks = createArray()
        
        tableView.delegate = self
        tableView.dataSource = self

        
        getStockData(url: DEMOstockURL)

    }

    func createArray() -> [Stock] {
        var tempStocks: [Stock] = []
        
        let stock1 = Stock(image: #imageLiteral(resourceName: "smiling-face-with-open-mouth"), title: "Ayy Stock is good! \(stockSymbol[0])")
        let stock2 = Stock(image: #imageLiteral(resourceName: "smiling-face-with-sunglasses"), title: "Stock gradually grows \(stockSymbol[1])")
        let stock3 = Stock(image: #imageLiteral(resourceName: "upside-down-face"), title: "Oups, a small dip \(stockSymbol[2])")
        let stock4 = Stock(image: #imageLiteral(resourceName: "smiling-face-with-open-mouth-and-cold-sweat"), title: "This one still dips \(stockSymbol[3])")

        tempStocks.append(stock1)
        tempStocks.append(stock2)
        tempStocks.append(stock3)
        tempStocks.append(stock4)
        
        return tempStocks
    }

}

extension StockListScreen: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    //called at every cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stockRow = stocks[indexPath.row]
        
        //cell variable configured
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockCell") as! StockCell
        cell.setStock(stock: stockRow)
        
        return cell 
    }
    
    //MARK: - Networking
    /***************************************************************/
    
    func getStockData(url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    
                    print("Sucess! Got the Stock data")
                    
                    print(response.result.value!)
                    let stockJSON : JSON = JSON(response.result.value!)
                    
                    self.updateStockData(json: stockJSON)
                    
                } else {
                    print("Error: \(String(describing: response.result.error))")
                    //                    self.stockPriceLabel.text = "Error getting Data"
                }
        }
        
    }
    
    //MARK: - JSON Parsing
    //    /***************************************************************/
    
    func updateStockData(json : JSON) {
        
        //get price of stock
        if let stockResult = json["Time Series (Daily)"]["2018-07-31"]["1. open"].string  {
            
            //updated price label here
            
            print("stock price \(stockResult)")
        } else {
            //stockPriceLabel.text = "Price Unavailable"
        }
        
        //get name of stock
        if let stockResult2 = json["Meta Data"]["2. Symbol"].string {
            
            //updated Symbol label here
            
            print("stock name \(stockResult2)")
            //stockSymbolLabel.text = "Symbol Unavailable"
            
        } else {
            
        }
    }
}
