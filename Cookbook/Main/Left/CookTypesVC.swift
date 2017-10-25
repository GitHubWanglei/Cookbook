//
//  CookTypesVC.swift
//  Cookbook
//
//  Created by wanglei on 2017/10/18.
//  Copyright © 2017年 wanglei. All rights reserved.
//

import Cocoa

class CookTypesVC: NSViewController {

    @IBOutlet var splitView: NSSplitView!
    @IBOutlet var leftView: NSView!
    @IBOutlet var rightView: NSView!
    var didSelectedCookTypeClosure: ((_ model: CookbookDtailResultModel)->())?
    
    lazy var leftVC: CookTypesLeftVC? = {
        let vc = CookTypesLeftVC.init(nibName: NSNib.Name("CookTypesLeftVC"), bundle: nil)
        return vc
    }()
    lazy var rightVC: CookTypesRightVC? = {
        let vc = CookTypesRightVC.init(nibName: NSNib.Name("CookTypesRightVC"), bundle: nil)
        return vc
    }()
    
    var cookbookTypesModel: CookbookTypeModel? {
        didSet{
            leftVC?.cookbookTypesModel = cookbookTypesModel
        }
    }
    
    func didSeletedCookType(closure: ((_ model: CookbookDtailResultModel)->())?) {
        didSelectedCookTypeClosure = closure
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.layoutSplitView()
        
        rightView.addSubview((self.rightVC?.view)!)
        leftView.addSubview((self.leftVC?.view)!)
        leftVC?.view.snp.makeConstraints({ (make) in
            make.top.left.bottom.right.equalTo(0)
        })
        rightVC?.view.snp.makeConstraints({ (make) in
            make.top.left.bottom.right.equalTo(0)
        })
        leftVC?.didSelectedItem(selectedClosure: { [weak self](typeList) in
            self?.rightVC?.typeList = typeList
        })
        rightVC?.didSeletedItem(selectedItem: { [weak self] (model) in
            if let closure = self?.didSelectedCookTypeClosure{
                closure(model!)
            }
        })
    }
    
    func layoutSplitView() {
        leftView.snp.makeConstraints { (make) in
            make.width.equalTo(100)
        }
        rightView.snp.makeConstraints { (make) in
            make.width.equalTo(100)
        }
    }
    
}
