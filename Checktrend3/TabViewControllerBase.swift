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
    var tabBarTitle: String = ""
    var tabMainTitle: String = ""
    var tabUrl: String = ""
    let TableViewCellIdentifier:String = "MyCell"
    
    private var myItems: NSMutableArray = []
    private var myUrls: NSMutableArray = []
    private var myDescriptions: NSMutableArray = []
    private var myTableView: UITableView!
    
    var tabbarButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.greenColor()
        
        setUp()
        
        //tabbar設定
        self.title = tabMainTitle
        self.tabBarItem.title = tabBarTitle
        //上のボタン
        tabbarButton = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "onClickNavBarButton")
        self.navigationItem.leftBarButtonItem = tabbarButton
        
        //上のボタン
        //var settingBtn:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        //settingBtn.addTarget(self, action: "onClickNavBarButton", forControlEvents: UIControlEvents.TouchUpInside)
        //settingBtn.frame = CGRectMake(0, 0, 24, 24)
        //settingBtn.setImage(UIImage(named: "Info.png"), forState: .Normal)
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: settingBtn)

        //戻るボタンを設定
        let backButtonText = NSLocalizedString("BACK_BUTTON_TITLE", comment: "back")
        let backButtonItem = UIBarButtonItem(title: backButtonText, style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        
        showList()
        connection()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            
            //google analytics
            let screenName = reflect(self).summary
            println (screenName)
            var tracker = GAI.sharedInstance().defaultTracker
            tracker.set(kGAIScreenName, value: screenName)
            var builder = GAIDictionaryBuilder.createScreenView()
            tracker.send(builder.build() as [NSObject : AnyObject])
        }
    }
    
    //tabbarボタンを押したとき
    func onClickNavBarButton() {
        connection()
    }
    
    func setUp() {
        tabBarTitle = ""
        tabMainTitle = ""
        tabUrl = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func connection() {
        var tmpItems:NSMutableArray = []
        var tmpUrls:NSMutableArray = []
        var tmpDescriptions:NSMutableArray = []
        
        println(tabUrl)
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        Alamofire.request(.GET, tabUrl, parameters: ["foo": "bar"])
            .responseSwiftyJSON({ (request, response, json, error) in
//              println(json)
                for (key: String, subJson: JSON) in json {
                    for (key: String, subsubJson: JSON) in subJson["items"] {
                        //TODO クラス作る
                        tmpItems.addObject(subsubJson["title"].string!) //要素がないとアプリが落ちる
                        tmpUrls.addObject(subsubJson["link"].string!)
                        tmpDescriptions.addObject(subsubJson["description"].string!)
                    }
                }

                self.myItems = tmpItems
                self.myUrls = tmpUrls
                self.myDescriptions = tmpDescriptions

                self.reloadTable()
                
                println(error)
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            })
    }

    
    func showList() {
        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        // TableViewの生成 (status bar分を引く)
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: TableViewCellIdentifier)
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
    }
    
    
    //Cellが選択された時
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Num: \(indexPath.row)")
        println("Value: \(myItems[indexPath.row])")
        println("Url: \(myUrls[indexPath.row])")
        
        let second = WebViewController()
        second.startUrl = myUrls[indexPath.row] as! String
        second.viewTitle = myItems[indexPath.row] as! String
        self.navigationController?.pushViewController(second, animated: true)
    }

    //Cell総数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myItems.count
    }
    
    //Cellへの値のセット
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = UITableViewCell(
            style: UITableViewCellStyle.Subtitle,
            reuseIdentifier:TableViewCellIdentifier )
        cell.textLabel!.text = "\(myItems[indexPath.row])"
        cell.detailTextLabel!.text = "\(myDescriptions[indexPath.row])"

        return cell
    }
    
    func reloadTable() {
        self.myTableView.reloadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }

}
