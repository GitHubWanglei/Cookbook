//
//  CookbookTypeModel.swift
//  Cookbook
//
//  Created by wanglei on 2017/10/17.
//  Copyright © 2017年 wanglei. All rights reserved.
//

import Cocoa
import ObjectMapper

class CookbookTypeModel: Mappable {
    
    var code: String?
    var charge: Bool
    var msg: String?
    var result: CookbookTypeResult?
    
    required init?(map: Map) {
        charge = true
    }
    
    func mapping(map: Map) {
        code <- map["code"]
        charge <- map["charge"]
        msg <- map["msg"]
        result <- map["result"]
    }
    
}

class CookbookTypeResult: Mappable {
    
    var status: String?
    var msg: String?
    var result: [CookbookTypeDetailList]
    
    required init?(map: Map) {
        result = []
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        msg <- map["msg"]
        result <- map["result"]
    }
}

class CookbookTypeDetailList: Mappable {
    
    var classid: String?
    var name: String?
    var parentid: String?
    var list: [CookbookTypeDetail]
    
    required init?(map: Map) {
        list = []
    }
    
    func mapping(map: Map) {
        classid <- map["classid"]
        name <- map["name"]
        parentid <- map["parentid"]
        list <- map["list"]
    }
}

class CookbookTypeDetail: Mappable {
    
    var classid: String?
    var name: String?
    var parentid: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        classid <- map["classid"]
        name <- map["name"]
        parentid <- map["parentid"]
    }
    
}








