//
//  FirstViewController.swift
//  Checktrend3
//
//  Created by tatsuya endo on 2015/06/20.
//  Copyright (c) 2015年 tattyamm. All rights reserved.
//

import UIKit

class TabViewController1: TabViewControllerBase {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //青色の画面を表示
        self.view.backgroundColor = UIColor.greenColor()
        
        println("tabTitle = " + tabTitle)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setUp() {
        tabTitle = "Google"
    }
    
}

