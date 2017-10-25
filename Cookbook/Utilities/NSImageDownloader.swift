//
//  NSImageDownloader.swift
//  NSImageCategory
//
//  Created by wanglei on 2017/10/19.
//  Copyright © 2017年 wanglei. All rights reserved.
//

import Foundation
import Cocoa

extension NSImage {
    
    class func requestImage(_ urlString: String, completion: @escaping ((_ data: Data?)->())) {
        
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                if let resultData = data {
                    DispatchQueue.main.async {
                        completion(resultData)
                    }
                }
            }else{
                print("_______\(error!.localizedDescription)")
            }
        }
        task.resume()
        
    }
    
}
