import UIKit
import Alamofire
import SwiftyJSON
import KRProgressHUD

class TabViewControllerBase: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tabBarTitle: String = ""
    var tabMainTitle: String = ""
    var tabUrl: String = ""
    let TableViewCellIdentifier:String = "MyCell"
    
    private var myItems: NSMutableArray = ["..."]
    private var myUrls: NSMutableArray = [""]
    private var myDescriptions: NSMutableArray = [""]
    private var myTableView: UITableView!
    
    var tabbarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()

        //tabbar設定
        self.title = tabMainTitle
        self.tabBarItem.title = tabBarTitle
        //上のボタン
        tabbarButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(TabViewControllerBase.onClickReloadButton))
        self.navigationItem.leftBarButtonItem = tabbarButton

        showList()
        connection()
    }
    
    func setUp() {
        tabBarTitle = ""
        tabMainTitle = ""
        tabUrl = ""
    }

    func connection() {
        print(tabUrl)
        let tmpItems:NSMutableArray = []
        let tmpUrls:NSMutableArray = []
        let tmpDescriptions:NSMutableArray = []

        showNetworkActivityIndicator()
        Alamofire.request(tabUrl, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for (_,subJson):(String, JSON) in json {
                    for (_,subsubJson):(String, JSON) in subJson["items"] {
                        print(subsubJson["title"].string ?? "")
                        tmpItems.add(subsubJson["title"].string ?? "") //適当
                        tmpUrls.add(subsubJson["link"].string ?? "")
                        tmpDescriptions.add(subsubJson["description"].string ?? "")
                    }
                }
                self.myItems = tmpItems
                self.myUrls = tmpUrls
                self.myDescriptions = tmpDescriptions
                
                self.hideNetworkActivityIndicator()
                self.reloadTable()
            case .failure(let error):
                print(error)
                tmpItems.add(NSLocalizedString("MESSAGE_LOADING_ERROR", comment: "network error"))
                tmpUrls.add("https://twitter.com/search-home")  //無しの方がいいが適当に設定
                tmpDescriptions.add("")
                self.myItems = tmpItems
                self.myUrls = tmpUrls
                self.myDescriptions = tmpDescriptions
                
                self.hideNetworkActivityIndicator()
                self.reloadTable()
            }
        }
    }

    //tabbarボタンを押したとき
    @objc func onClickReloadButton() {
        print("reload")
        connection()
    }

    func showList() {
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        // TableViewの生成 (status bar分を引く)
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: TableViewCellIdentifier)
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
    }
    
    //Cellが選択された時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(myItems[indexPath.row])")
        print("Url: \(myUrls[indexPath.row])")

        //webviewを作る
        let webview = WebViewController()
        webview.startUrl = myUrls[indexPath.row] as? String ?? "https://twitter.com/search-home"
        self.navigationController?.pushViewController(webview, animated: true)
    }
    
    //Cell総数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(
            style: UITableViewCell.CellStyle.subtitle,
            reuseIdentifier:TableViewCellIdentifier )
        cell.textLabel!.text = "\(myItems[indexPath.row])"
        cell.detailTextLabel!.text = "\(myDescriptions[indexPath.row])"
        
        return cell
    }

    //ヘッダーの大きさ
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        //return 50
        return 0
    }
    //ヘッダー
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        /*
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50)
        view.backgroundColor = UIColor.green
        //ヘッダーに追加するラベルを生成
        let headerLabel = UILabel()
        headerLabel.frame =  CGRect(x: 0, y: 5, width: self.view.frame.size.width, height: 40)
        headerLabel.text = tabMainTitle
        headerLabel.font = UIFont.boldSystemFont(ofSize: 22)
        headerLabel.textColor = UIColor.white
        headerLabel.textAlignment = NSTextAlignment.center
        view.addSubview(headerLabel)
        return view
        */
        return nil
    }
    
    func reloadTable() {
        self.myTableView.reloadData()
    }
    
    func showNetworkActivityIndicator() {
        KRProgressHUD.show()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
    }
    
    func hideNetworkActivityIndicator() {
        KRProgressHUD.dismiss()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false;
    }
}
