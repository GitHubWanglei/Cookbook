//
//  SearchResultRightVC.swift
//  Cookbook
//
//  Created by wanglei on 2017/10/24.
//  Copyright © 2017年 wanglei. All rights reserved.
//

import Cocoa
import WebKit

class SearchResultRightVC: NSViewController {
    
    @IBOutlet var webView: WKWebView!
    
    var cookbookDetailModel: CookbookDtailModel? {
        didSet{
            loadHtmlString()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        NotificationCenter.default.addObserver(self, selector: #selector(showDetail(object:)), name: NSNotification.Name(rawValue: "SearchResultRightVC_showDetail"), object: nil)
        
    }
    
    func loadHtmlString() {
        var htmlString = "<!DOCTYPEhtml><htmllang=\"en\"><head><metacharset=\"UTF-8\"><title>测试</title><style>*{margin:0;padding:0;}body{width:720px}hr{margin-right:10px;margin-left:10px;}div{margin-left:20px;margin-right:20px;}.title{display:block;text-align:center;line-height:60px;}.pic{margin-top:10px;display:inline-block;margin-left:20px;}.peopleAndTime{margin-left:0px;display:inline-block;margin-bottom:10px;font-weight:200;}.content{display:block;margin-left:20px;margin-bottom:10px;font-weight:100;}.content-title{font-size: 23px;}.material{margin-left:20px;margin-top:10px;margin-bottom:10px;font-weight:100;}.material.material-title{font-size:23px;}.process{margin-left:20px;margin-top:10px;margin-bottom:20px;}.process.process-title{font-size:23px;}.process.process1{margin-left:0px;}.process img{margin-left:20px;}span{font-size: 20px;font-family: -apple-system, BlinkMacSystemFont,\"Segoe UI\", \"Roboto\", \"Oxygen\", \"Ubuntu\", \"Cantarell\",\"Fira Sans\", \"Droid Sans\", \"Helvetica Neue\", sans-serif;}strong{font-size: 20px;font-family: -apple-system, BlinkMacSystemFont,\"Segoe UI\", \"Roboto\", \"Oxygen\", \"Ubuntu\", \"Cantarell\",\"Fira Sans\", \"Droid Sans\", \"Helvetica Neue\", sans-serif;}</style></head>"
        
        var zhuliao = ""
        var fuliao = ""
        for i in 0..<(cookbookDetailModel?.material)!.count{
            let model = (cookbookDetailModel?.material)![i]
            if model.type == "1"{//主料
                if i == ((cookbookDetailModel?.material)!.count - 1){
                    zhuliao.append(model.mname! + model.amount!)
                }else{
                    zhuliao.append(model.mname! + model.amount! + "、")
                }
            }else{//辅料
                if i == ((cookbookDetailModel?.material)!.count - 1){
                    fuliao.append(model.mname! + model.amount!)
                }else{
                    fuliao.append(model.mname! + model.amount! + "、")
                }
            }
        }
        
        let yongliao = "<body><span class=\"title\"><h1>\((cookbookDetailModel?.name)!)</h1></span><hr><div  class=\"pic\"><img  src=\"\((cookbookDetailModel?.pic)!)\"></div><div  class=\"peopleAndTime\"><span>人数: \((cookbookDetailModel?.peoplenum)!)</span><br/><span>准备时间: \((cookbookDetailModel?.preparetime)!)</span><br/><span>烹饪时间: \((cookbookDetailModel?.cookingtime)!)</span></div><dic  class=\"content\"><strong class=\"content-title\">简介</strong><br/><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\((cookbookDetailModel?.content)!)</span><br/><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;分类: \((cookbookDetailModel?.tag)!)</span></dic><hr><div class=\"material\"><strong class=\"material-title\">用料</strong><br/><span class=\"material-zhuliao\">主料: \(zhuliao)</span><br/><span class=\"material-fuliao\">辅料: \(fuliao)</span></div><hr>"
        
        htmlString.append(yongliao)
        htmlString.append("<div class=\"process\"><strong class=\"process-title\">步骤</strong><br/>")
        for i in 0..<(cookbookDetailModel?.process)!.count {
            let process = (cookbookDetailModel?.process)![i]
            htmlString.append("<div class=\"process1\"><span class=\"content\">\(i+1). \((process.pcontent)!)</span><img src=\"\((process.pic)!)\"></div><br>")
        }
        htmlString.append("</div></body></html>")
        
        webView.loadHTMLString(htmlString, baseURL: nil)
    }
    
    @objc func showDetail(object: NSNotification?) {
        
        if let model = (object?.object as? CookbookDtailModel) {
            print("_________\((model.name)!)")
            cookbookDetailModel = model
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
