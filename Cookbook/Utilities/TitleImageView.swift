//
//  TitleImageView.swift
//  Cookbook
//
//  Created by wanglei on 2017/10/24.
//  Copyright © 2017年 wanglei. All rights reserved.
//

import Cocoa

class TitleImageView: NSImageView {
    
    override var mouseDownCanMoveWindow: Bool{
        return true
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // Drawing code here.
    }
    
}
