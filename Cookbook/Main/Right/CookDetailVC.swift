//
//  CookDetailVC.swift
//  Cookbook
//
//  Created by wanglei on 2017/10/18.
//  Copyright © 2017年 wanglei. All rights reserved.
//

import Foundation
import Cocoa

class CookDetailVC: NSViewController {
    
    @IBOutlet var splitView: NSSplitView!
    @IBOutlet var leftView: NSView!
    @IBOutlet var rightView: NSView!
    
    @IBOutlet var maskBox: NSBox!
    @IBOutlet var infoLabel: NSTextField!
    
    lazy var leftVC: CookDetailLeftVC? = {
        let vc = CookDetailLeftVC.init(nibName: NSNib.Name("CookDetailLeftVC"), bundle: nil)
        return vc
    }()
    lazy var rightVC: CookDetailRightVC? = {
        let vc = CookDetailRightVC.init(nibName: NSNib.Name("CookDetailRightVC"), bundle: nil)
        return vc
    }()
    
    var cookbookDetailResultModel: CookbookDtailResultModel? {
        didSet{
            
            if cookbookDetailResultModel?.result?.result?.num != nil {
                if Int((cookbookDetailResultModel?.result?.result?.num)!)! > 0 {
                    maskBox.isHidden = true
                    leftVC?.cookbookDtailSecondeResult = cookbookDetailResultModel?.result?.result
                }else{
                    maskBox.isHidden = false
                    infoLabel.stringValue = "暂无菜谱信息."
                    infoLabel.font = NSFont.systemFont(ofSize: 20, weight: .ultraLight)
                }
            }else{
                maskBox.isHidden = false
                infoLabel.stringValue = "暂无菜谱信息."
                infoLabel.font = NSFont.systemFont(ofSize: 20, weight: .ultraLight)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        infoLabel.stringValue = "欢迎使用cookbook!"
        infoLabel.font = NSFont.systemFont(ofSize: 30, weight: .ultraLight)
        NotificationCenter.default.addObserver(self, selector: #selector(showMaskBox), name: NSNotification.Name(rawValue: "CookDetailVC_showMaskBox"), object: nil)
        
        self.leftView.snp.makeConstraints { (make) in
            make.width.equalTo(150)
        }
        
        rightView.addSubview((self.rightVC?.view)!)
        leftView.addSubview((self.leftVC?.view)!)
        leftVC?.view.snp.makeConstraints({ (make) in
            make.top.left.bottom.right.equalTo(0)
        })
        rightVC?.view.snp.makeConstraints({ (make) in
            make.top.left.bottom.right.equalTo(0)
        })
        
    }
    
    @objc func showMaskBox() {
        infoLabel.stringValue = "正在加载..."
        infoLabel.font = NSFont.systemFont(ofSize: 20, weight: .ultraLight)
        maskBox.isHidden = false
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
