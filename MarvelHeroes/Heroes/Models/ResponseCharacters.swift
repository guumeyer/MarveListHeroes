//
//  ResponseCharacter.swift
//  MarvelHeros
//
//  Created by gustavo r meyer on 8/12/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import Foundation

public class ResponseCharacters {
    public var code : Int?
    public var status : String?
    public var copyright : String?
    public var attributionText : String?
    public var attributionHTML : String?
    public var data : ResponseData?
    public var etag : String?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let responseCharacters = ResponseCharacters.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of ResponseCharacters Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [ResponseCharacters]
    {
        var models:[ResponseCharacters] = []
        for item in array
        {
            models.append(ResponseCharacters(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let responseCharacters = ResponseCharacters(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Json4Swift_Base Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        code = dictionary["code"] as? Int
        status = dictionary["status"] as? String
        copyright = dictionary["copyright"] as? String
        attributionText = dictionary["attributionText"] as? String
        attributionHTML = dictionary["attributionHTML"] as? String
        if (dictionary["data"] != nil) { data = ResponseData(dictionary: dictionary["data"] as! NSDictionary) }
        etag = dictionary["etag"] as? String
    }
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.code, forKey: "code")
        dictionary.setValue(self.status, forKey: "status")
        dictionary.setValue(self.copyright, forKey: "copyright")
        dictionary.setValue(self.attributionText, forKey: "attributionText")
        dictionary.setValue(self.attributionHTML, forKey: "attributionHTML")
        dictionary.setValue(self.data?.dictionaryRepresentation(), forKey: "data")
        dictionary.setValue(self.etag, forKey: "etag")
        
        return dictionary
    }
    
}
