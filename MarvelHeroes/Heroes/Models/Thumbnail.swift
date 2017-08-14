//
//  Thumbnail.swift
//  MarvelHeros
//
//  Created by gustavo r meyer on 8/12/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import UIKit

public class Thumbnail: NSObject {
    
    public var path : String?
    public var extensionFile : String?
    
    func getName()->String {
    
        return "\(path!).\(extensionFile!)"
    }
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let thumbnail_list = Thumbnail.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Thumbnail Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Thumbnail]
    {
        var models:[Thumbnail] = []
        for item in array
        {
            models.append(Thumbnail(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let thumbnail = Thumbnail(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Thumbnail Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        path = dictionary["path"] as? String
        extensionFile = dictionary["extension"] as? String
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.path, forKey: "path")
        dictionary.setValue(self.extensionFile, forKey: "extension")
        
        return dictionary
    }
}
