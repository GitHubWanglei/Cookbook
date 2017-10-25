//
//  CookTypesLeftVC.swift
//  Cookbook
//
//  Created by wanglei on 2017/10/18.
//  Copyright © 2017年 wanglei. All rights reserved.
//

import Cocoa

let CookTypesLeftVCItem_identifier = "CookTypesLeftVCItem_identifier"

class CookTypesLeftVC: NSViewController {
    
    @IBOutlet var scrollView: NSScrollView!
    @IBOutlet var collectionView: NSCollectionView!
    var selectedItemClosure: (([CookbookTypeDetail])->())?
    
    var cookbookTypesModel: CookbookTypeModel? {
        didSet{
            if (cookbookTypesModel?.result?.result) != nil {
                collectionView.reloadData()
                collectionView.selectItems(at: [IndexPath(item: 0, section: 0)], scrollPosition: NSCollectionView.ScrollPosition.top)
                let typeList = cookbookTypesModel?.result?.result[0].list
                if let closure = selectedItemClosure {
                    closure(typeList!)
                }
                scrollView.scrollerStyle = .overlay
            }
        }
    }
    
    let itemNormalColor = NSColor.init(red: 175/255.0, green: 212/255.0, blue: 70/255.0, alpha: 1)
    let itemSelectedColor = NSColor.init(red: 28/255.0, green: 85/255.0, blue: 38/255.0, alpha: 1)
    
    func didSelectedItem(selectedClosure: ((_ typeList: [CookbookTypeDetail])->())?) {
        selectedItemClosure = selectedClosure
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.green.cgColor
        
        collectionView.wantsLayer = true
        collectionView.layer?.backgroundColor = itemNormalColor.cgColor
        collectionView.register(CookTypesLeftVCCollectionViewItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier(CookTypesLeftVCItem_identifier))
        
    }
    
}

extension CookTypesLeftVC: NSCollectionViewDataSource {
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        if let model = cookbookTypesModel {
            return (model.result?.result.count)!
        }
        return 0
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(CookTypesLeftVCItem_identifier), for: indexPath) as! CookTypesLeftVCCollectionViewItem
        
        item.nameLabel.stringValue = (cookbookTypesModel?.result?.result[indexPath.item].name)!
        item.nameLabel.wantsLayer = true
        item.nameLabel.layer?.backgroundColor = NSColor.clear.cgColor
        item.nameLabel.textColor = NSColor.white
        
        item.view.wantsLayer = true
        if item.isSelected {
            item.view.layer?.backgroundColor = itemSelectedColor.cgColor
        }else{
            item.view.layer?.backgroundColor = itemNormalColor.cgColor
        }
        
        return item
    }
    
}

extension CookTypesLeftVC: NSCollectionViewDelegate {
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        let item = collectionView.item(at: (indexPaths.first?.item)!) as! CookTypesLeftVCCollectionViewItem
        item.isSelected = true
        item.view.wantsLayer = true
        item.view.layer?.backgroundColor = itemSelectedColor.cgColor
        
        let typeList = cookbookTypesModel?.result?.result[(indexPaths.first?.item)!].list
        if let closure = selectedItemClosure {
            closure(typeList!)
        }
        
    }
    
    func collectionView(_ collectionView: NSCollectionView, didDeselectItemsAt indexPaths: Set<IndexPath>) {
        let item = collectionView.item(at: (indexPaths.first?.item)!) as! CookTypesLeftVCCollectionViewItem
        item.isSelected = false
        item.view.wantsLayer = true
        item.view.layer?.backgroundColor = itemNormalColor.cgColor
        
    }
    
}

















