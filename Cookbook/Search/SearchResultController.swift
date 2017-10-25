//
//  SearchResultController.swift
//  Cookbook
//
//  Created by wanglei on 2017/10/17.
//  Copyright © 2017年 wanglei. All rights reserved.
//

import Cocoa

class SearchResultController: NSViewController {
    
    @IBOutlet var scrollView: NSSplitView!
    @IBOutlet var leftView: NSView!
    @IBOutlet var rightView: NSView!
    @IBOutlet var maskView: NSBox!
    
    lazy var leftVC: SearchResultLeftVC? = {
        let vc = SearchResultLeftVC.init(nibName: NSNib.Name("SearchResultLeftVC"), bundle: nil)
        return vc
    }()
    lazy var rightVC: SearchResultRightVC? = {
        let vc = SearchResultRightVC.init(nibName: NSNib.Name("SearchResultRightVC"), bundle: nil)
        return vc
    }()
    
    var cookbookDetailResultModel: CookbookDtailResultModel?{
        didSet{
            
            if cookbookDetailResultModel?.result?.result?.num != nil {
                if Int((cookbookDetailResultModel?.result?.result?.num)!)! > 0 {
                    maskView.isHidden = true
                    scrollView.isHidden = false
                    leftVC?.cookbookDtailSecondeResult = cookbookDetailResultModel?.result?.result
                }else{
                    maskView.isHidden = false
                    scrollView.isHidden = true
                }
            }else{
                maskView.isHidden = false
                scrollView.isHidden = true
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        
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
    
}
