//
//  Data.swift
//  MarvelHeros
//
//  Created by gustavo r meyer on 8/12/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import Foundation

public class ResponseData {
    
    public var offset : Int?
    public var limit : Int?
    public var total : Int?
    public var count : Int?
    public var results : Array<Character>?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let data_list = Data.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Data Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [ResponseData]
    {
        var models:[ResponseData] = []
        for item in array
        {
            models.append(ResponseData(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let data = Data(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Data Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        offset = dictionary["offset"] as? Int
        limit = dictionary["limit"] as? Int
        total = dictionary["total"] as? Int
        count = dictionary["count"] as? Int
        if (dictionary["results"] != nil) { results =  Character.modelsFromDictionaryArray(array: dictionary["results"] as! NSArray) }
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.offset, forKey: "offset")
        dictionary.setValue(self.limit, forKey: "limit")
        dictionary.setValue(self.total, forKey: "total")
        dictionary.setValue(self.count, forKey: "count")
        
        return dictionary
    }

}
