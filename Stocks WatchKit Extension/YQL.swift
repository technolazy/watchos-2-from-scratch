//
//  YQL.swift
//  Stocks
//
//  Created by Derek Jensen on 11/19/15.
//  Copyright © 2015 Derek Jensen. All rights reserved.
//

import Foundation

public class YQL
{
    private class var prefix: String {
        return "http://query.yahooapis.com/v1/public/yql?q="
    }
    
    private class var suffix: String {
        return "&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=";
    }
    
    public class func query(statement: String) -> NSDictionary
    {
        let query = "\(prefix)\(statement.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)\(suffix)"
        
        let jsonData = (try? String(contentsOfURL: NSURL(string: query)!, encoding: NSUTF8StringEncoding))?.dataUsingEncoding(NSUTF8StringEncoding)
        
        let result = { _ -> NSDictionary in
            if let data = jsonData
            {
                return (try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
            }
            
            return NSDictionary()
        }()
        
        return result;
    }
}
