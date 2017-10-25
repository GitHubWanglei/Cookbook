//
//  CookTypesRightVC.swift
//  Cookbook
//
//  Created by wanglei on 2017/10/18.
//  Copyright © 2017年 wanglei. All rights reserved.
//

import Foundation
import Cocoa

let CookTypesRightVCItem_identifier = "CookTypesRightVCItem_identifier"

class CookTypesRightVC: NSViewController {

    @IBOutlet var scrollView: NSScrollView!
    @IBOutlet var collectionView: NSCollectionView!
    var lastSelectedItem = 0
    var didSeletedItemClosure: ((_ model: CookbookDtailResultModel?)->())?
    
    var typeList = [CookbookTypeDetail]() {
        didSet{
            if typeList.count > 0 {
                collectionView.reloadData()
                scrollView.scrollerStyle = .overlay
            }
        }
    }
    
    let itemNormalColor = NSColor.white
    let itemSelectedColor = NSColor.init(red: 235/255.0, green: 208/255.0, blue: 165/255.0, alpha: 1)
    
    func didSeletedItem(selectedItem: ((_ model: CookbookDtailResultModel?)->())?) {
        didSeletedItemClosure = selectedItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        collectionView.wantsLayer = true
        collectionView.layer?.backgroundColor = itemNormalColor.cgColor
        collectionView.register(CookTypesRightVCCollectionViewItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier(CookTypesRightVCItem_identifier))
        
        
    }
    
}

extension CookTypesRightVC: NSCollectionViewDataSource {
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        if typeList.count > 0 {
            return typeList.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(CookTypesRightVCItem_identifier), for: indexPath) as! CookTypesRightVCCollectionViewItem
        
        item.nameLabel.stringValue = (typeList[indexPath.item].name)!
        item.nameLabel.wantsLayer = true
        item.nameLabel.layer?.backgroundColor = NSColor.clear.cgColor
        item.nameLabel.textColor = NSColor.black
        item.nameLabel.font = NSFont.systemFont(ofSize: 15, weight: .thin)
        
        item.view.wantsLayer = true
        if item.isSelected {
            item.view.layer?.backgroundColor = itemSelectedColor.cgColor
        }else{
            item.view.layer?.backgroundColor = itemNormalColor.cgColor
        }
        
        return item
    }
    
}

extension CookTypesRightVC: NSCollectionViewDelegate {
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        
        let currentSelectedItem = indexPaths.first?.item
        var item = collectionView.item(at: (indexPaths.first?.item)!) as? CookTypesRightVCCollectionViewItem
        if item == nil {
            if lastSelectedItem > currentSelectedItem! {//正在往上选择
                collectionView.scrollToItems(at: indexPaths, scrollPosition: NSCollectionView.ScrollPosition.top)
            }else if lastSelectedItem < currentSelectedItem! {//正在往下选择
                collectionView.scrollToItems(at: indexPaths, scrollPosition: NSCollectionView.ScrollPosition.bottom)
            }
        }
        item = collectionView.item(at: (indexPaths.first?.item)!) as? CookTypesRightVCCollectionViewItem
        item?.isSelected = true
        item?.view.wantsLayer = true
        item?.view.layer?.backgroundColor = itemSelectedColor.cgColor
        lastSelectedItem = (indexPaths.first?.item)!
        
        let model = typeList[(indexPaths.first?.item)!]
        if let classid = model.classid {
            
            NotificationCenter.default.post(name: NSNotification.Name("CookDetailVC_showMaskBox"), object: nil)
            
            NetworkManager.shareManger.getCookbookDetail(classid: classid, start: 0, num: 20) {[weak self] (model) in
                    if let model = model{
                        print("______\((model.msg)!)")
                        if let closure = self?.didSeletedItemClosure {
                            DispatchQueue.main.async {
                                closure(model)
                            }
                    }
                }
                
            }
        }
        
    }
    
    func collectionView(_ collectionView: NSCollectionView, didDeselectItemsAt indexPaths: Set<IndexPath>) {
        
        let item = collectionView.item(at: (indexPaths.first?.item)!) as? CookTypesRightVCCollectionViewItem
        item?.isSelected = false
        item?.view.wantsLayer = true
        item?.view.layer?.backgroundColor = itemNormalColor.cgColor
        
    }
    
}












