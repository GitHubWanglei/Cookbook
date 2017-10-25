//
//  CookDetailLeftVC.swift
//  Cookbook
//
//  Created by wanglei on 2017/10/20.
//  Copyright © 2017年 wanglei. All rights reserved.
//

import Cocoa

class CookDetailLeftVC: NSViewController {

    @IBOutlet var scrollView: NSScrollView!
    @IBOutlet var collectionView: NSCollectionView!
    var lastSelectedItem = 0
    
    let itemNormalColor = NSColor.white
    let itemSelectedColor = NSColor.init(red: 209/255.0, green: 241/255.0, blue: 253/255.0, alpha: 1)
    
    let CookDetailLeftVCItem_identifier = "CookDetailLeftVCItem_identifier"
    
    var cookbookDtailSecondeResult: CookbookDtailSecondeResult? {
        didSet{
            collectionView.reloadData()
            scrollView.scrollerStyle = .overlay
            collectionView.selectItems(at: [IndexPath(item: 0, section: 0)], scrollPosition: NSCollectionView.ScrollPosition.top)
            if let model = cookbookDtailSecondeResult?.list[0] {
                NotificationCenter.default.post(name: NSNotification.Name("CookDetailRightVC_showDetail"), object: model)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(CookDetailLeftVCCollectionViewItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier(CookDetailLeftVCItem_identifier))
        
    }
    
}

extension CookDetailLeftVC: NSCollectionViewDataSource {
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        if let list = cookbookDtailSecondeResult?.list {
            return list.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(CookDetailLeftVCItem_identifier), for: indexPath) as! CookDetailLeftVCCollectionViewItem
        
        if let model = cookbookDtailSecondeResult?.list[indexPath.item] {
            item.picURLString = model.pic
            item.nameLabel.stringValue = (model.name)!
        }
        if item.isSelected {
            item.view.wantsLayer = true
            item.view.layer?.backgroundColor = itemSelectedColor.cgColor
        }else{
            item.view.wantsLayer = true
            item.view.layer?.backgroundColor = itemNormalColor.cgColor
        }
        
        return item
        
    }
    
}

extension CookDetailLeftVC: NSCollectionViewDelegate {
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        let currentSelectedItem = indexPaths.first?.item
        var item = collectionView.item(at: (indexPaths.first?.item)!) as? CookDetailLeftVCCollectionViewItem
        if item == nil {
            if lastSelectedItem > currentSelectedItem! {//正在往上选择
                collectionView.scrollToItems(at: indexPaths, scrollPosition: NSCollectionView.ScrollPosition.top)
            }else if lastSelectedItem < currentSelectedItem! {//正在往下选择
                collectionView.scrollToItems(at: indexPaths, scrollPosition: NSCollectionView.ScrollPosition.bottom)
            }
        }
        item = collectionView.item(at: (indexPaths.first?.item)!) as? CookDetailLeftVCCollectionViewItem
        item?.isSelected = true
        item?.view.wantsLayer = true
        item?.view.layer?.backgroundColor = itemSelectedColor.cgColor
        
        if let model = cookbookDtailSecondeResult?.list[(indexPaths.first?.item)!] {
            NotificationCenter.default.post(name: NSNotification.Name("CookDetailRightVC_showDetail"), object: model)
        }
        
    }
    
    func collectionView(_ collectionView: NSCollectionView, didDeselectItemsAt indexPaths: Set<IndexPath>) {
        
        let item = collectionView.item(at: (indexPaths.first?.item)!) as? CookDetailLeftVCCollectionViewItem
        item?.isSelected = false
        item?.view.wantsLayer = true
        item?.view.layer?.backgroundColor = itemNormalColor.cgColor
        
    }
    
}



















