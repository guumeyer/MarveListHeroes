//
//  MarvelServiceAPIProtocol.swift
//  MarvelHeros
//
//  Created by gustavo r meyer on 8/12/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import Foundation

protocol MarvelServiceAPIProtocol {
    ///v1/public/characters
    
    typealias charactersCompleteHandler = (ResponseCharacters)->()
    typealias warningCompleteHandler = (String)->()
    typealias errorCompleteHandler = (Error)->()
    
    /**
     List all Marvel Characters.
    
     - parameter offset: Number of characters that would like to returno. Maximum value is 100 defined by Marvel API.
     - parameter success: Asynchronous success with ResponseCharacters.
     - parameter waring: Asynchronous waring message.
     - parameter error: Asynchronous error message.
     */
    func getCharacteres(offset:Int, charactersCompleteHandler:@escaping charactersCompleteHandler, warningCompleteHandler: @escaping warningCompleteHandler, errorCompleteHandler:@escaping errorCompleteHandler)
}
