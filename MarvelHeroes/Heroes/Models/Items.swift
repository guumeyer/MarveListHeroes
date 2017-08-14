//
//  Items.swift
//  MarvelHeros
//
//  Created by gustavo r meyer on 8/12/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import Foundation

public class Items: NSObject {
    public var resourceURI : String?
    public var name : String?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let items_list = Items.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Items Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Items]
    {
        var models:[Items] = []
        for item in array
        {
            models.append(Items(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let items = Items(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Items Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        resourceURI = dictionary["resourceURI"] as? String
        name = dictionary["name"] as? String
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.resourceURI, forKey: "resourceURI")
        dictionary.setValue(self.name, forKey: "name")
        
        return dictionary
    }
}
