//
//  Character.swift
//  MarvelHeros
//
//  Created by gustavo r meyer on 8/12/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import UIKit

public class Character {
    public var id : Int?
    public var name : String?
    public var description : String?
    public var modified : String?
    public var resourceURI : String?
    
    public var image: UIImage?
    
    public var urls : Array<Urls>?
    public var thumbnail : Thumbnail?
    public var comics : Comics?
    public var stories : Stories?
    public var events : Events?
    public var series : Series?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let results_list = Results.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Results Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Character]
    {
        var models:[Character] = []
        for item in array
        {
            models.append(Character(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let results = Results(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Results Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        description = dictionary["description"] as? String
        modified = dictionary["modified"] as? String
        resourceURI = dictionary["resourceURI"] as? String
        if (dictionary["urls"] != nil) { urls = Urls.modelsFromDictionaryArray(array: dictionary["urls"] as! NSArray) }
        if (dictionary["thumbnail"] != nil) { thumbnail = Thumbnail(dictionary: dictionary["thumbnail"] as! NSDictionary) }
        if (dictionary["comics"] != nil) { comics = Comics(dictionary: dictionary["comics"] as! NSDictionary) }
        if (dictionary["stories"] != nil) { stories = Stories(dictionary: dictionary["stories"] as! NSDictionary) }
        if (dictionary["events"] != nil) { events = Events(dictionary: dictionary["events"] as! NSDictionary) }
        if (dictionary["series"] != nil) { series = Series(dictionary: dictionary["series"] as! NSDictionary) }
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.name, forKey: "name")
        dictionary.setValue(self.description, forKey: "description")
        dictionary.setValue(self.modified, forKey: "modified")
        dictionary.setValue(self.resourceURI, forKey: "resourceURI")
        dictionary.setValue(self.thumbnail?.dictionaryRepresentation(), forKey: "thumbnail")
        dictionary.setValue(self.comics?.dictionaryRepresentation(), forKey: "comics")
        dictionary.setValue(self.stories?.dictionaryRepresentation(), forKey: "stories")
        dictionary.setValue(self.events?.dictionaryRepresentation(), forKey: "events")
        dictionary.setValue(self.series?.dictionaryRepresentation(), forKey: "series")
        
        return dictionary
    }

}
