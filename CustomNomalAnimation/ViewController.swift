//
//  ViewController.swift
//  CustomNomalAnimation
//
//  Created by 彭盛凇 on 16/9/2.
//  Copyright © 2016年 huangbaoche. All rights reserved.
//

import UIKit

    let Width   = UIScreen.mainScreen().bounds.size.width
    let Height  = UIScreen.mainScreen().bounds.size.height

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let dataList = ["1","2","3"]
    let identifier = "cellID"
    
    let headerView : UIImageView = UIImageView()
    var tableView  : UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        creatHeaderView()
        
        creatTableView()
        
    }
    
    func creatHeaderView() {
        
        headerView.frame = CGRectMake(0, 0, Width, 200)
        headerView.image = UIImage(named: "101.jpg")
        view.addSubview(headerView)
    }
    
    func creatTableView() {
        
        tableView.frame = CGRectMake(0, 0, Width, Height)
        tableView.backgroundColor = UIColor.clearColor()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
    }
    
    //MARK: UITableViewDataSource && UITableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
        cell.textLabel?.text = dataList[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRectMake(0, 0, Width, 200))
        view.backgroundColor = UIColor.clearColor()
        return view
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    //MARK: UIScrollViewDelegate
    @available(iOS 2.0, *)
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if (scrollView.contentOffset.y <= 0) {//下滑
            
            let scrollViewChageValue = -scrollView.contentOffset.y
            
            let scale = scrollViewChageValue / headerView.frame.size.height + 1.0
            
            print("\(-scrollView.contentOffset.y) ------------\(scale)")
            
            headerView.frame.size.height = scale * 200
            
            headerView.frame.size.width  = scale * Width
            
            headerView.frame.origin.x    = -((scale * Width) - Width) / 2
            
            //更改View子视图的层级关系
            view.bringSubviewToFront(headerView)
            
        }else{//上滑
            
            headerView.frame.origin.y = -(scrollView.contentOffset.y)/2.5;
            view.bringSubviewToFront(tableView)
        }
    }// any offset changes
}