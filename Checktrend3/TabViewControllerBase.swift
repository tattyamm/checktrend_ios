//
//  TabViewControllerBase.swift
//  Checktrend3
//
//  Created by tatsuya endo on 2015/06/21.
//  Copyright (c) 2015年 tattyamm. All rights reserved.
//

/*
llibrary
http://vdeep.net/xcode63-cocoapods-alamofire-swiftyjson


http://qiita.com/tsumekoara/items/7293c54762afeeb10ed5
のようにgoogleajax経由dedouda?

http://qiita.com/yukihamada/items/9b0067f905418105a2c6

*/

import UIKit

import Alamofire
import SwiftyJSON
import Alamofire_SwiftyJSON

class TabViewControllerBase: UIViewController {
    var tabTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //青色の画面を表示
        self.view.backgroundColor = UIColor.yellowColor()
        
        setUp()
        
       // connection()
        
        connection2()
    }
    
    func setUp() {
        tabTitle = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func connection() {
        var myUrl:NSURL = NSURL(string:"http://checktrend.herokuapp.com/api/trend/google.json")!
        // リクエストを生成.
        var myRequest:NSURLRequest  = NSURLRequest(URL: myUrl)
        // 送信処理を始める.
        NSURLConnection.sendAsynchronousRequest(myRequest, queue: NSOperationQueue.mainQueue(), completionHandler: self.connectionDidFinished)
    }
    
    func connectionDidFinished(res: NSURLResponse?, data: NSData?, error: NSError?) {
        if let resultError = error
        {
            println(resultError.description)
        }
        
        if let httpResponse = res as? NSHTTPURLResponse {
            let statusCode = httpResponse.statusCode
            if statusCode != 200 {
                println("sendAsynchronousRequest status code = \(statusCode); response = \(res)")
            }
        }
        
        var myData:NSString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
        println(myData)
        
    }
    
    func connection2() {
        Alamofire.request(.GET, "http://checktrend.herokuapp.com/api/trend/google.json", parameters: ["foo": "bar"])
            .responseSwiftyJSON({ (request, response, json, error) in
                println(json)
                for (key: String, subJson: JSON) in json {
                    // keyにはJSONのキーが設定されている。
//                    println(subJson["items"])
                    for (key: String, subsubJson: JSON) in subJson["items"] {
                        println(subsubJson["title"])
                        
                    }

                    
                }
                
                println(error)
            })
    }
    
}
