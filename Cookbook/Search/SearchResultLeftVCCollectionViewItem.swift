//
//  SearchResultLeftVCCollectionViewItem.swift
//  Cookbook
//
//  Created by wanglei on 2017/10/24.
//  Copyright © 2017年 wanglei. All rights reserved.
//

import Cocoa

class SearchResultLeftVCCollectionViewItem: NSCollectionViewItem {
    
    @IBOutlet var pic: NSImageView!
    @IBOutlet var nameLabel: NSTextField!
    var picURLString: String? {
        didSet {
            NSImage.requestImage(picURLString!) {[weak self] (data) in
                self?.pic.image = NSImage.init(data: data!)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
