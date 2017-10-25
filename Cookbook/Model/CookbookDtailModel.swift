//
//  CookbookDtailModel.swift
//  Cookbook
//
//  Created by wanglei on 2017/10/20.
//  Copyright © 2017年 wanglei. All rights reserved.
//

import Cocoa
import ObjectMapper

class CookbookDtailResultModel: Mappable {
    var code: String?
    var charge: Bool
    var msg: String?
    var result: CookbookDtailFirstResult?
    
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

class CookbookDtailFirstResult: Mappable{
    
    var status: String?
    var msg: String?
    var result: CookbookDtailSecondeResult?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        msg <- map["msg"]
        result <- map["result"]
    }
    
}

class CookbookDtailSecondeResult: Mappable {
    
    var num: String?
    var list = [CookbookDtailModel]()
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        num <- map["num"]
        list <- map["list"]
    }
    
}

class CookbookDtailModel: Mappable {
    var id: String?
    var classid: String?
    var name: String?
    var peoplenum: String?
    var preparetime: String?
    var cookingtime: String?
    var content: String?
    var pic: String?
    var tag: String?
    var material: [CookbookDtailMaterial]?
    var process: [CookbookDtailProcess]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        classid <- map["classid"]
        name <- map["name"]
        peoplenum <- map["peoplenum"]
        preparetime <- map["preparetime"]
        cookingtime <- map["cookingtime"]
        content <- map["content"]
        pic <- map["pic"]
        tag <- map["tag"]
        material <- map["material"]
        process <- map["process"]
    }
    
}

class CookbookDtailMaterial: Mappable {
    var mname: String?
    var type: String?
    var amount: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        mname <- map["mname"]
        type <- map["type"]
        amount <- map["amount"]
    }
    
}

class CookbookDtailProcess: Mappable {
    var pcontent: String?
    var pic: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        pcontent <- map["pcontent"]
        pic <- map["pic"]
    }
    
}














