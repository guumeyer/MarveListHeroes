//
//  Urls.swift
//  MarvelHeros
//
//  Created by gustavo r meyer on 8/12/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import Foundation

public class Urls: NSObject {

    public var type : String?
    public var url : String?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let urls_list = Urls.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Urls Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Urls]
    {
        var models:[Urls] = []
        for item in array
        {
            models.append(Urls(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let urls = Urls(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Urls Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        type = dictionary["type"] as? String
        url = dictionary["url"] as? String
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.type, forKey: "type")
        dictionary.setValue(self.url, forKey: "url")
        
        return dictionary
    }

}
