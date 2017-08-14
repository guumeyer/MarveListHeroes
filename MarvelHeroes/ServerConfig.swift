//
//  ServerConfig.swift
//  MarvelHeros
//
//  Created by gustavo r meyer on 8/12/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import Foundation

struct ServerConfig {
    
    struct HttpSettings {
        
        static let url = "https://gateway.marvel.com/"
        
        static func getDefaultParametersHttp() -> [String:Any] {
            
            let timestamp = NSDate().timeIntervalSince1970.description
            
            let hash = Marvel.getHash(timestamp)
            
            return [
                "apikey": Marvel.publicKey,
                "ts": timestamp,
                "hash": hash
            ]
            
        }
    }
    
    struct Marvel {
        //TODO: Create a Setting.plist file
        
        static let publicKey = "7d9dfb0b23ab31ec67d181f5fe09f230"
        static let privateKey = "25e5b55b1124843c966cbc3121d5d57b9237eaf1"
        
        static func getHash(_ timestamp:String) -> String{
            return "\(timestamp)\(Marvel.privateKey)\(Marvel.publicKey)".md5()
        }
    }

}
