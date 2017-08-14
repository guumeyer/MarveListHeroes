//
//  HeroesDataManagerProtocol.swift
//  MarvelHeroes
//
//  Created by gustavo r meyer on 8/13/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import UIKit

protocol HeroesDataManagerProtocol {

    typealias completeHandler = ([Character])->()
    typealias warningHandler = (String)->()
    typealias errorHandler = (Error)->()
    

    func numberOfItemsInFeed() -> Int
    
    func object(at index: Int) -> Character
    
    func clear()
    
    func requestPage(completeHandler:@escaping completeHandler, warningHandler: @escaping warningHandler, errorHandler:@escaping errorHandler)
    
    func refresh(completeHandler:@escaping completeHandler, warningHandler: @escaping warningHandler, errorHandler:@escaping errorHandler )
    
    func loadDataFromServer(replacingData: Bool, completeHandler:@escaping completeHandler, warningHandler: @escaping warningHandler, errorHandler:@escaping errorHandler)

}
