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

https://sites.google.com/a/gclue.jp/swift-docs/ni-yinki100-ios/uikit/uibarbuttonitemno-she-zhi

navigationbar
http://qiita.com/mochizukikotaro/items/f053495eb130e92e13e8

*/

import UIKit

import Alamofire
import SwiftyJSON
import Alamofire_SwiftyJSON


class TabViewControllerBase: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tabTitle: String = ""
    
    private var myItems: NSMutableArray = []//["TEST1", "TEST2", "TEST3"]
    private var myUrls: NSMutableArray = []
    private var myTableView: UITableView!
    
     var addBtn: UIBarButtonItem!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //青色の画面を表示
        self.view.backgroundColor = UIColor.yellowColor()
        
        setUp()
        
        //tabbar設定
        self.title = tabTitle
        addBtn = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "onClick")
        self.navigationItem.rightBarButtonItem = addBtn
        
       // connection()
        
        connection2()
        
        showList()
    }
    
    //tabbarボタンを押したとき
    func onClick() {
        let second = WebViewController()
        self.navigationController?.pushViewController(second, animated: true)
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
        var tmpItems:NSMutableArray = []
        var tmpUrls:NSMutableArray = []
        
        Alamofire.request(.GET, "http://checktrend.herokuapp.com/api/trend/google.json", parameters: ["foo": "bar"])
            .responseSwiftyJSON({ (request, response, json, error) in
//              println(json)
                for (key: String, subJson: JSON) in json {
                    for (key: String, subsubJson: JSON) in subJson["items"] {
                        //TODO クラス作る
                        tmpItems.addObject(subsubJson["title"].string!) //要素がないとアプリが落ちる
                        tmpUrls.addObject(subsubJson["link"].string!)
                    }
                }

                self.myItems = tmpItems
                self.myUrls = tmpUrls
                self.reloadTable()
                
                println(error)
            })
    }

    
    func showList() {
        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        // TableViewの生成する(status barの高さ分ずらして表示).
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        
        // Cell名の登録をおこなう.
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        // DataSourceの設定をする.
        myTableView.dataSource = self
        
        // Delegateを設定する.
        myTableView.delegate = self
        
        // Viewに追加する.
        self.view.addSubview(myTableView)
    }
    
    
    /*
    Cellが選択された際に呼び出されるデリゲートメソッド.
    */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Num: \(indexPath.row)")
        println("Value: \(myItems[indexPath.row])")
        println("Url: \(myUrls[indexPath.row])")
        
        // 遷移するViewを定義する.
        let myWebViewController: UIViewController = WebViewController()
        // アニメーションを設定する.
        myWebViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        // Viewの移動する.
        self.presentViewController(myWebViewController, animated: true, completion: nil)
    }
    
    /*
    Cellの総数を返すデータソースメソッド.
    (実装必須)
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myItems.count
    }
    
    /*
    Cellに値を設定するデータソースメソッド.
    (実装必須)
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 再利用するCellを取得する.
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as! UITableViewCell
        
        // Cellに値を設定する.
        cell.textLabel!.text = "\(myItems[indexPath.row])"

        return cell
    }
    
    func reloadTable() {
        self.myTableView.reloadData()
    }
    
}
