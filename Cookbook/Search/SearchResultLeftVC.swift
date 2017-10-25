//
//  SearchResultLeftVC.swift
//  Cookbook
//
//  Created by wanglei on 2017/10/24.
//  Copyright © 2017年 wanglei. All rights reserved.
//

import Cocoa

class SearchResultLeftVC: NSViewController {
    
    @IBOutlet var scrollView: NSScrollView!
    @IBOutlet var collectionView: NSCollectionView!
    var lastSelectedItem = 0
    
    let itemNormalColor = NSColor.white
    let itemSelectedColor = NSColor.init(red: 209/255.0, green: 241/255.0, blue: 253/255.0, alpha: 1)
    
    let SearchResultLeftVCItem_identifier = "SearchResultLeftVCItem_identifier"
    
    var cookbookDtailSecondeResult: CookbookDtailSecondeResult? {
        didSet{
            collectionView.reloadData()
            scrollView.scrollerStyle = .overlay
            collectionView.selectItems(at: [IndexPath(item: 0, section: 0)], scrollPosition: NSCollectionView.ScrollPosition.top)
            if let model = cookbookDtailSecondeResult?.list[0] {
                NotificationCenter.default.post(name: NSNotification.Name("SearchResultRightVC_showDetail"), object: model)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        collectionView.register(SearchResultLeftVCCollectionViewItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier(SearchResultLeftVCItem_identifier))
        collectionView.delegate = self
        
    }
    
}

extension SearchResultLeftVC: NSCollectionViewDataSource {
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        if let list = cookbookDtailSecondeResult?.list {
            return list.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(SearchResultLeftVCItem_identifier), for: indexPath) as! SearchResultLeftVCCollectionViewItem
        
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

extension SearchResultLeftVC: NSCollectionViewDelegate {
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        print("__________hhhhhh")
        let currentSelectedItem = indexPaths.first?.item
        var item = collectionView.item(at: (indexPaths.first?.item)!) as? SearchResultLeftVCCollectionViewItem
        if item == nil {
            if lastSelectedItem > currentSelectedItem! {//正在往上选择
                collectionView.scrollToItems(at: indexPaths, scrollPosition: NSCollectionView.ScrollPosition.top)
            }else if lastSelectedItem < currentSelectedItem! {//正在往下选择
                collectionView.scrollToItems(at: indexPaths, scrollPosition: NSCollectionView.ScrollPosition.bottom)
            }
        }
        item = collectionView.item(at: (indexPaths.first?.item)!) as? SearchResultLeftVCCollectionViewItem
        item?.isSelected = true
        item?.view.wantsLayer = true
        item?.view.layer?.backgroundColor = itemSelectedColor.cgColor
        
        if let model = cookbookDtailSecondeResult?.list[(indexPaths.first?.item)!] {
            NotificationCenter.default.post(name: NSNotification.Name("SearchResultRightVC_showDetail"), object: model)
        }
        
    }
    
    func collectionView(_ collectionView: NSCollectionView, didDeselectItemsAt indexPaths: Set<IndexPath>) {
        
        let item = collectionView.item(at: (indexPaths.first?.item)!) as? SearchResultLeftVCCollectionViewItem
        item?.isSelected = false
        item?.view.wantsLayer = true
        item?.view.layer?.backgroundColor = itemNormalColor.cgColor
        
    }
    
}














