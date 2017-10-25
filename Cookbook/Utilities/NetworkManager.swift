//
//  NetworkManager.swift
//  Cookbook
//
//  Created by wanglei on 2017/10/17.
//  Copyright © 2017年 wanglei. All rights reserved.
//

import Cocoa
import ObjectMapper

let APPKEY = "6e1411d36c8d1a62b5d8bc6230fd6d9c"

class NetworkManager: NSObject {
    
    static let shareManger = NetworkManager()
    
    private override init() {
        
    }
    
    public func getAllCookbookTypes(complication: @escaping (_ model: CookbookTypeModel?)->()) {
        
        let urlString = "https://way.jd.com/jisuapi/recipe_class?appkey=\(APPKEY)"
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("______\(error!.localizedDescription)")
            }else{
                let jsonString = String.init(data: data!, encoding: String.Encoding.utf8)
                if let model = Mapper<CookbookTypeModel>().map(JSONString: jsonString!){
                    complication(model)
                }
            }
        }
        task.resume()
        
    }
    
    public func getCookbookDetail(classid: String, start: Int, num: Int, complication: @escaping (_ model: CookbookDtailResultModel?)->()) {
        
        let urlString = "https://way.jd.com/jisuapi/byclass?classid=\(classid)&start=\(start)&num=\(num)&appkey=\(APPKEY)"
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("______\(error!.localizedDescription)")
            }else{
                let jsonString = String.init(data: data!, encoding: String.Encoding.utf8)
                if let model = Mapper<CookbookDtailResultModel>().map(JSONString: jsonString!){
                    complication(model)
                }
            }
        }
        task.resume()
        
    }
    
    func getCookbook(searchString: String, complication: @escaping (_ model: CookbookDtailResultModel?)->()) {
        
        let urlString = "https://way.jd.com/jisuapi/search?keyword=\(searchString)&num=\(20)&appkey=\(APPKEY)"
        let endcodeString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: endcodeString!)
        let task = URLSession.shared.dataTask(with: url!) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("______\(error!.localizedDescription)")
            }else{
                let jsonString = String.init(data: data!, encoding: String.Encoding.utf8)
                if let model = Mapper<CookbookDtailResultModel>().map(JSONString: jsonString!){
                    complication(model)
                }
            }
        }
        task.resume()
        
    }
    
    
}














