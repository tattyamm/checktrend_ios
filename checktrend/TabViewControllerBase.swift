import UIKit

import Alamofire
import SwiftyJSON

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
        tabbarButton = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: #selector(TabViewControllerBase.onClickReloadButton))
        self.navigationItem.leftBarButtonItem = tabbarButton

        //戻るボタンを設定
        let backButtonText = NSLocalizedString("BACK_BUTTON_TITLE", comment: "back")
        let backButtonItem = UIBarButtonItem(title: backButtonText, style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        
        showList()
        connection()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if (UIApplication.sharedApplication().delegate as? AppDelegate) != nil {

            //google analytics
            let screenName = (NSStringFromClass(self.dynamicType))
            print("screenname = " + screenName)

            let tracker = GAI.sharedInstance().defaultTracker
            tracker.set(kGAIScreenName, value: screenName)
            let builder = GAIDictionaryBuilder.createScreenView()
            tracker.send(builder.build() as [NSObject : AnyObject])
        }
    }
    
    //tabbarボタンを押したとき
    func onClickReloadButton() {
        trackEvent("button", action: "reload", label: "tabview controller", value: nil)
        connection()
    }
    
    func trackEvent(category: String, action: String, label: String, value: NSNumber?) {
        let tracker = GAI.sharedInstance().defaultTracker
        let trackDictionary = GAIDictionaryBuilder.createEventWithCategory(category, action: action, label: label, value: value).build()
        tracker.send(trackDictionary as [NSObject : AnyObject])
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
            print(resultError.description)
        }
        
        if let httpResponse = res as? NSHTTPURLResponse {
            let statusCode = httpResponse.statusCode
            if statusCode != 200 {
                print("sendAsynchronousRequest status code = \(statusCode); response = \(res)")
            }
        }
        
        let myData:NSString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
        print(myData)
        
    }
    
    func connection() {
        print(tabUrl)
        let tmpItems:NSMutableArray = []
        let tmpUrls:NSMutableArray = []
        let tmpDescriptions:NSMutableArray = []
        
        SVProgressHUD.show()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true

        //request
        request(.GET, tabUrl, parameters: ["foo": "bar"])
            .responseJSON {response in
                let json = JSON(response.result.value ?? "{}")
                for (_,subJson):(String, JSON) in json {
                    for (_,subsubJson):(String, JSON) in subJson["items"] {
                        //TODO クラス作る
//                        println(subsubJson["title"].string ?? "")
                        tmpItems.addObject(subsubJson["title"].string ?? "") //適当
                        tmpUrls.addObject(subsubJson["link"].string ?? "")
                        tmpDescriptions.addObject(subsubJson["description"].string ?? "")
                    }
                }

                self.myItems = tmpItems
                self.myUrls = tmpUrls
                self.myDescriptions = tmpDescriptions

                self.reloadTable()
                
                SVProgressHUD.dismiss()
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }

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
        print("Num: \(indexPath.row)")
        print("Value: \(myItems[indexPath.row])")
        print("Url: \(myUrls[indexPath.row])")

        let num = indexPath.row
        let startUrl = myUrls[indexPath.row] as! String
        let viewTitle = myItems[indexPath.row] as! String
        trackEvent("list", action: "select", label: viewTitle, value: num)
        
        let second = WebViewController()
        second.startUrl = startUrl
        second.viewTitle = viewTitle
        self.navigationController?.pushViewController(second, animated: true)
    }

    //Cell総数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myItems.count
    }
    
    //Cellへの値のセット
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(
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
        SVProgressHUD.dismiss()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }

}