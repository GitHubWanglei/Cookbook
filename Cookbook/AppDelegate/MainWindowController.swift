//
//  MainWindowController.swift
//  Cookbook
//
//  Created by wanglei on 2017/10/17.
//  Copyright © 2017年 wanglei. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    @IBOutlet var progressIndicator: NSProgressIndicator!
    @IBOutlet var searchField: NSSearchField!
    var mainVC: MainViewController?
    var searchString = ""
    var searchVC: SearchResultController?
    var windowFrame: NSRect?
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        window?.isOpaque = false
        progressIndicator.isHidden = true
        progressIndicator.startAnimation(nil)
        searchField.sendsWholeSearchString = true
        searchField.isEnabled = false
        mainVC = self.window?.contentViewController as? MainViewController
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        window?.titleVisibility = .hidden
        self.window?.standardWindowButton(NSWindow.ButtonType.zoomButton)?.isHidden = true
        self.requestAllCookTypes()
    }
    
    @IBAction func searchAction(_ sender: NSSearchField) {
        let result = sender.stringValue.replacingOccurrences(of: " ", with: "")
        windowFrame = self.window?.frame
        if result.count > 0 {
            searchString = result
            self.requestSearchResult()
        }else{
            self.window?.contentViewController = mainVC
        }
        self.window?.setFrame(windowFrame!, display: true)
    }
    
    func requestAllCookTypes() {
        let manager = NetworkManager.shareManger
        manager.getAllCookbookTypes { [weak self] (model: CookbookTypeModel?) in
            if let result = model {
                DispatchQueue.main.async {
                    print("_______\(result.msg!)")
                    self?.mainVC?.cookbookTypesModel = result
                    self?.mainVC?.maskView.isHidden = true
                    self?.searchField.isEnabled = true
                    self?.window?.isOpaque = false
                }
            }
        }
    }

    func requestSearchResult() {
        
        progressIndicator.isHidden = false
        let manager = NetworkManager.shareManger
        manager.getCookbook(searchString: searchString) { [weak self] (model: CookbookDtailResultModel?) in
            if let result = model {
                DispatchQueue.main.async {
                    self?.progressIndicator.isHidden = true
                    self?.searchVC = SearchResultController.init(nibName: NSNib.Name("SearchResultController"), bundle: nil)
                    self?.window?.contentViewController = self?.searchVC
                    self?.searchVC?.cookbookDetailResultModel = result
                    self?.window?.setFrame((self?.windowFrame!)!, display: true)
                    self?.window?.isOpaque = false
                }
            }
        }
        
    }
    
}



















