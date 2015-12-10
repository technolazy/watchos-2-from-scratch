//
//  InterfaceController.swift
//  Stocks WatchKit Extension
//
//  Created by Derek Jensen on 11/19/15.
//  Copyright © 2015 Derek Jensen. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var lblSymbol: WKInterfaceLabel!
    @IBOutlet var lblName: WKInterfaceLabel!
    @IBOutlet var lblLast: WKInterfaceLabel!
    @IBOutlet var lblChange: WKInterfaceLabel!
    
    let symbolKey = "symbol"
    let nameKey = "Name"
    let lastKey = "LastTradePriceOnly"
    let changeKey = "ChangeinPercent"
    
    let symbols:[String] = ["AAPL", "MSFT", "GOOG"]
    var symbolIndex = 0
    
    @IBAction func btnChangeSymbol() {
        symbolIndex += 1
        if symbolIndex >= symbols.count {
            symbolIndex = 0
        }
        
        update()
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
       update()
    }
    
    func update() {
        let query = "select * from yahoo.finance.quotes where symbol = '\(symbols[symbolIndex])'"
        let results = YQL.query(query)
        let quote = results["query"]!["results"]!!["quote"]! as! NSDictionary
        
        let symbol = quote[symbolKey] as! String
        let name = quote[nameKey] as! String
        let last = quote[lastKey] as! String
        let change = quote[changeKey] as! String
        
        lblSymbol.setText(symbol)
        lblName.setText(name)
        lblLast.setText(last)
        lblChange.setText(change)
        
        let green = UIColor.greenColor()
        let red = UIColor.redColor()
        let white = UIColor.whiteColor()
        
        if change.rangeOfString("+") != nil {
            lblSymbol.setTextColor(green)
            lblChange.setTextColor(green)
        }else if change.rangeOfString("-") != nil {
            lblSymbol.setTextColor(red)
            lblChange.setTextColor(red)
        } else {
            lblSymbol.setTextColor(white)
            lblChange.setTextColor(white)
        }
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
