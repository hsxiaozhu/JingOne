//
//  LineView.swift
//  JingOne
//
//  Created by 大可立青 on 15/9/6.
//  Copyright © 2015年 大可立青. All rights reserved.
//

import UIKit

class LineView: UIView {
    
    var labelTitle = ["动态","关注","粉丝","文章","博客"]
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetRGBStrokeColor(context, 0, 0, 0, 0.5)
        CGContextSetLineWidth(context, 0.5)
        
        for var i = 1;i<5;i++ {
            CGContextMoveToPoint(context, rect.width/5 * CGFloat(i), 10)
            CGContextAddLineToPoint(context, rect.width/5 * CGFloat(i), rect.height - 10)
        }
        
        CGContextMoveToPoint(context, 0, 5)
        CGContextAddLineToPoint(context, rect.width, 5)
        
        CGContextMoveToPoint(context, 0, rect.height - 5)
        CGContextAddLineToPoint(context, rect.width, rect.height - 5)
        
        CGContextStrokePath(context)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        for var i = 0;i < 5;i++ {
            let label = UILabel(frame: CGRectMake(CGFloat(i) * frame.width/5, frame.height/3, frame.width/5, frame.height/3*2))
            label.text = labelTitle[i]
            label.textColor = UIColor.grayColor()
            label.font = UIFont.systemFontOfSize(13)
            label.textAlignment = NSTextAlignment.Center
            self.addSubview(label)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
