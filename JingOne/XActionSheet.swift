//
//  XActionSheet.swift
//  JingOne
//
//  Created by 大可立青 on 15/9/7.
//  Copyright © 2015年 大可立青. All rights reserved.
//

import UIKit

protocol XActionSheetDelegate{
    func buttonClick(index:Int)
}

class XActionSheet: UIViewController {
    
    var width:CGFloat!
    var height:CGFloat!
    let buttonHeight:CGFloat = 40 
    
    var layerView:UIView!
    var cancelButton:UIButton!
    var btnArray = [UIButton()]
    
    var delegate:XActionSheetDelegate!
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.width = self.view.bounds.size.width
        self.height = self.view.bounds.size.height
        self.view.backgroundColor = UIColor.clearColor()
        //解决点击后黑屏
        self.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        let tap = UITapGestureRecognizer(target: self, action: "tap")
        self.view.addGestureRecognizer(tap)
        
        btnArray = Array()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
    下拉菜单消失
    */
    func tap(){
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    /**
    添加取消按钮
    */
    func addCancelButtonWithTitle(title:String){
        if layerView == nil{
            layerView = UIView(frame: CGRectMake(self.width*0.1, self.height - (CGFloat(self.btnArray.count) * self.buttonHeight + self.buttonHeight + 30), self.width * 0.8, CGFloat(self.btnArray.count) * self.buttonHeight + self.buttonHeight + 20))
            layerView.layer.cornerRadius = 5
            layerView.layer.masksToBounds = true
            layerView.alpha = 0.8
            self.view.addSubview(layerView)
        }else{
            var nowHeight = self.layerView.bounds.size.height
            nowHeight += 50
            layerView = UIView(frame: CGRectMake(self.width * 0.1, self.height - nowHeight, self.width * 0.8, nowHeight))
        }
        
        if cancelButton == nil{
            cancelButton = UIButton(frame: CGRectMake(0, CGFloat(btnArray.count)*buttonHeight+10, width*0.8, buttonHeight))
            cancelButton.setTitle(title, forState: UIControlState.Normal)
            cancelButton.layer.cornerRadius = 5
            cancelButton.layer.masksToBounds = true
            cancelButton.backgroundColor = UIColor.brownColor()
            cancelButton.addTarget(self, action: "tap", forControlEvents: UIControlEvents.TouchUpInside)
            layerView.addSubview(cancelButton)
        }
    }
    
    /**
    添加按钮
    */
    func addButtonWithTitle(title:String){
        if layerView == nil{
            layerView = UIView(frame: CGRectMake(width*0.1, self.height - (self.buttonHeight + 10), width*0.8,  self.buttonHeight + 20))
            layerView.layer.cornerRadius = 5
            layerView.layer.masksToBounds = true
            layerView.alpha = 0.8
            self.view.addSubview(layerView)
        }else{
            var nowHeight = self.layerView.bounds.size.height
            nowHeight += 40
            layerView.frame = CGRectMake(width * 0.1, height - nowHeight, width * 0.8, nowHeight)
            //layerView = UIView(frame: CGRectMake(self.width * 0.1, self.height - nowHeight, self.width * 0.8, nowHeight))
        }
        
        let btn = UIButton(frame: CGRectMake(0, CGFloat(btnArray.count) * buttonHeight, width * 0.8, buttonHeight - 1))
        btn.tag = btnArray.count
        btn.setTitle(title, forState: UIControlState.Normal)
        btn.addTarget(self, action: "buttonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        btn.backgroundColor = UIColor(red: 52.0/255.0, green: 170.0/255.0, blue: 135.0/255.0, alpha: 1)
        layerView.addSubview(btn)
        btnArray.append(btn)
        
        if cancelButton != nil{
            let cancelY = cancelButton.frame.origin.y
            cancelButton.frame = CGRectMake(0, cancelY + buttonHeight, width * 0.8, buttonHeight)
        }
    }
    
    func buttonClick(sender:AnyObject){
        self.dismissViewControllerAnimated(true, completion: nil)
        let btn = sender as! UIButton
        delegate.buttonClick(btn.tag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
