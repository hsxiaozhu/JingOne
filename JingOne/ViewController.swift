//
//  ViewController.swift
//  JingOne
//
//  Created by 大可立青 on 15/9/6.
//  Copyright © 2015年 大可立青. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,HZPhotoBrowserDelegate,XActionSheetDelegate,DoImagePickerControllerDelegate
{
    var tableView = UITableView()
    var objectArray = [String]()
    var i = 0
    var head:XHPathCover!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.tableView.frame = self.view.frame
        self.tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        
        for self.i;self.i<10;self.i++ {
            objectArray.append("\(i)")
        }
        
        self.tableView.addLegendFooterWithRefreshingTarget(self, refreshingAction: "footerRefresh")
        self.tableView.addLegendHeaderWithRefreshingTarget(self, refreshingAction: "headerRefresh")
        
        head = XHPathCover(frame: CGRectMake(0, 0, self.view.bounds.size.width, 200))
        head.setBackgroundImage(UIImage(named: "BG"))
        head.setAvatarImage(UIImage(named: "cute_girl.jpg"))
        head.isZoomingEffect = true
        head.setInfo(NSDictionary(objects: ["大可立青","安徽黄山"], forKeys:[XHUserNameKey,XHBirthdayKey]) as [NSObject:AnyObject])
        head.avatarButton.layer.cornerRadius = 33
        head.avatarButton.layer.masksToBounds = true
        
        head.avatarButton.addTarget(self, action: "photoBrowser", forControlEvents: UIControlEvents.TouchUpInside)
        
        head.handleRefreshEvent = {
            self.headerRefresh()
        }
        
        
        let headerView = UIView(frame: CGRectMake(0, 0, self.view.bounds.size.width, 260))
        let lineView = LineView(frame: CGRectMake(0, 200, self.view.bounds.size.width, 60))

        headerView.addSubview(head)
        headerView.addSubview(lineView)
        
        self.tableView.tableHeaderView = headerView
        
        
        SDImageCache.sharedImageCache().clearDisk()
        SDImageCache.sharedImageCache().clearMemory()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func photoBrowser(){
//        let browserVC = HZPhotoBrowser()
//        browserVC.sourceImagesContainerView = head.avatarButton
//        browserVC.imageCount = 1
//        browserVC.currentImageIndex = 0
//        browserVC.delegate = self
//        browserVC.show()
        let action = XActionSheet()
        action.delegate = self
        action.addCancelButtonWithTitle("取消")
        action.addButtonWithTitle("拍照")
        action.addButtonWithTitle("相册")
        action.addButtonWithTitle("高清大图")
        self.presentViewController(action, animated: true, completion: nil)
    }
    
    //MARK: - XActionSheetDelegate
    func buttonClick(index: Int) {
        //查看高清大图
        if index == 2{
            let browserVC = HZPhotoBrowser()
            browserVC.sourceImagesContainerView = head.avatarButton
            browserVC.imageCount = 1
            browserVC.currentImageIndex = 0
            browserVC.delegate = self
            browserVC.show()
        }
        //相册
        if index == 1{
            let picker = DoImagePickerController()
            picker.delegate = self
            picker.nMaxCount = 1
            picker.nColumnCount = 2
            self.presentViewController(picker, animated: true, completion: nil)
        }
    }
    
    //MARK: - DoImagePickerControllerDelegate方法
    func didCancelDoImagePickerController() {
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    func didSelectPhotosFromDoImagePickerController(picker: DoImagePickerController!, result aSelected: [AnyObject]!) {
        let image = aSelected.first as! UIImage
        head.avatarButton.setImage(image, forState: UIControlState.Normal)
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    //MARK: - HZPhotoBrowserDelegate方法
    func photoBrowser(browser: HZPhotoBrowser!, placeholderImageForIndex index: Int) -> UIImage! {
        return head.avatarButton.currentImage
    }
    
    func photoBrowser(browser: HZPhotoBrowser!, highQualityImageURLForIndex index: Int) -> NSURL! {
        let url = NSURL(string: "http://ac-hn8w3hlp.clouddn.com/dGWm2GEFNFoisI6beHBUQjD.png")
        return url
    }
    
    //MARK: - ScrollView
    func scrollViewDidScroll(scrollView: UIScrollView) {
        head.scrollViewDidScroll(scrollView)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        head.scrollViewDidEndDecelerating(scrollView)
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        head.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        head.scrollViewWillBeginDragging(scrollView)
    }
    
    //MARK: - UITableViewDelegate、UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) 
        //cell.textLabel?.text = "第\(objectArray[indexPath.row])行"
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        let imageView = UIImageView(frame: CGRectMake(10, 10, 60, 60))
        imageView.sd_setImageWithURL(NSURL(string: "http://ac-hn8w3hlp.clouddn.com/fVju6pA4WGzVGNGsVdVXEzB.png"), placeholderImage: UIImage(named: "cute_girl.jpg"))
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        cell.contentView.addSubview(imageView)
        
        let label = UILabel(frame: CGRectMake(80, 30, 200, 20))
        label.text = "第\(objectArray[indexPath.row])行"
        cell.contentView.addSubview(label)
        
        return cell
    }
    
    //MARK: - 上拉加载、下拉刷新、延时方法
    func footerRefresh(){
        ProgressHUD.show("加载中......")
        delay(2) { () -> () in
            let j = self.i + 10
            for self.i;self.i<j;self.i++ {
                self.objectArray.append("\(self.i)")
            }
            self.tableView.footer.endRefreshing()
            self.tableView.reloadData()
            ProgressHUD.showSuccess("加载完成！")
        }
    }
    
    func headerRefresh(){
        ProgressHUD.show("刷新中......")
        delay(2) { () -> () in
            self.objectArray.removeAll(keepCapacity: false)
            self.i = 0
            for self.i;self.i<10;self.i++ {
                self.objectArray.append("\(self.i)")
            }
            self.tableView.header.endRefreshing()
            self.tableView.reloadData()
            self.head.stopRefresh()
            ProgressHUD.showSuccess("刷新完成！")
        }
    }
    
    func delay(time:Double,closure:()->()){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
    }


}

