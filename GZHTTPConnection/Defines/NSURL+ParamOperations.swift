//
//  NSURL+ParamOperations.swift
//  Flingy
//
//  Created by Grady Zhuo on 2/27/15.
//  Copyright (c) 2015 Grady Zhuo. All rights reserved.
//

import Foundation
import UIKit


extension NSURL{
    
    func parametersDictionary() -> [String:String]{
        
        var md:[String:String] = [String:String]()
        let components:NSURLComponents! = NSURLComponents(URL: self, resolvingAgainstBaseURL: false)
        
        if SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO("8.0"){
            
            md = components.queryItems?.reduce(md, combine: { (var dict, item) -> [String:String] in
                let query = item 
                dict[query.name] = query.value
                return dict
            }) ?? [:]
            
        }else{
            if let query = components.query {
                
                let items = query.componentsSeparatedByString("&")
                
                for item in items {
                    
                    let queryItem = item.componentsSeparatedByString("=")
                    
                    if queryItem.count > 2 || queryItem.count == 0 {
                        continue
                    }
                    
                    md[queryItem.first! as String] = queryItem.last! as String
                    
                }
            }
            
            
        }
        
        
        return md
        
    }
}
