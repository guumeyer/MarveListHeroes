//
//  Stories.swift
//  MarvelHeros
//
//  Created by gustavo r meyer on 8/12/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import UIKit

public class Stories: NSObject {
    
    public var available : Int?
    public var returned : String?
    public var collectionURI : String?
    public var items : Array<Items>?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let stories_list = Stories.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Stories Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Stories]
    {
        var models:[Stories] = []
        for item in array
        {
            models.append(Stories(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let stories = Stories(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Stories Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        available = dictionary["available"] as? Int
        returned = dictionary["returned"] as? String
        collectionURI = dictionary["collectionURI"] as? String
        if (dictionary["items"] != nil) { items = Items.modelsFromDictionaryArray(array: dictionary["items"] as! NSArray) }
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.available, forKey: "available")
        dictionary.setValue(self.returned, forKey: "returned")
        dictionary.setValue(self.collectionURI, forKey: "collectionURI")
        
        return dictionary
    }

}
