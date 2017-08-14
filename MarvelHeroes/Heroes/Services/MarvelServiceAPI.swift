//
//  MarvelServiceAPI.swift
//  MarvelHeros
//
//  Created by gustavo r meyer on 8/12/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import UIKit
import Alamofire

public class MarvelServiceAPI: MarvelServiceAPIProtocol {
    
    /**
     List all Marvel Characters.
     
     - parameter offset: Number of characters that would like to returno. Maximum value is 100 defined by Marvel API.
     - parameter success: Asynchronous success with ResponseCharacters.
     - parameter waring: Asynchronous waring message.
     - parameter error: Asynchronous error message.
     */
    
    func getCharacteres(offset: Int,
                        charactersCompleteHandler: @escaping (ResponseCharacters) -> (),
                        warningCompleteHandler: @escaping (String) -> (),
                        errorCompleteHandler: @escaping (Error) -> ()) {
        
        let utilityQueue = DispatchQueue.global(qos: .utility)
        let url = ServerConfig.HttpSettings.url.appending("v1/public/characters")
//        
//        let headers = ["Content-Type":"application/json; charset=utf-8"]
//        
        var parameters = ServerConfig.HttpSettings.getDefaultParametersHttp()
        parameters["offset"] = offset
        print("url: \(url)")
        print("print: \(parameters)")

        
        Alamofire.request(url, parameters: parameters).responseJSON(queue: utilityQueue) { response in
        
            
            switch response.result {
            case .success:
                print("Validation Successful")
                
                if let json = response.result.value {
                    print("JSON: \(json)") // serialized json response
                    
                    let responseCharacters = ResponseCharacters(dictionary: json as! NSDictionary)
                    
                    if responseCharacters?.code != 200 {
                        warningCompleteHandler((responseCharacters?.status)!)
                        return
                    }
                    
                    charactersCompleteHandler(responseCharacters!)
                }

            case .failure(let error):
                print(error)
                errorCompleteHandler(error)
            }
            
            
        }
    }
}
