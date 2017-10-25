//
//  MainViewController.swift
//  Cookbook
//
//  Created by wanglei on 2017/10/17.
//  Copyright © 2017年 wanglei. All rights reserved.
//

import Cocoa
import SnapKit

class MainViewController: NSViewController {

    @IBOutlet var maskView: NSBox!
    @IBOutlet var splitView: NSSplitView!
    @IBOutlet var leftView: NSView!
    @IBOutlet var rightView: NSView!
    
    var leftVC: CookTypesVC? = CookTypesVC.init(nibName: NSNib.Name("CookTypesVC"), bundle: nil)
    var rightVC: CookDetailVC? = CookDetailVC.init(nibName: NSNib.Name("CookDetailVC"), bundle: nil)
    
    var cookbookTypesModel: CookbookTypeModel? {
        didSet{
            leftVC?.cookbookTypesModel = cookbookTypesModel
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.layoutSplitView()
        self.addLeftVCAndRightVC()
        
        leftVC?.didSeletedCookType(closure: { [weak self] (model) in
            self?.rightVC?.cookbookDetailResultModel = model
        })
        
    }
    
    override func viewWillAppear() {
        self.view.window?.isOpaque = false
    }
    
    func addLeftVCAndRightVC() {
        leftView.addSubview((self.leftVC?.view)!)
        leftVC?.view.snp.makeConstraints({ (make) in
            make.top.right.bottom.right.equalTo(0)
        })
        rightView.addSubview((self.rightVC?.view)!)
    }
    
    func layoutSplitView() {
        leftView.snp.makeConstraints { (make) in
            make.width.equalTo(200)
        }
        rightView.snp.makeConstraints { (make) in
            make.width.equalTo(700)
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

