//
//  HeroesDataManager.swift
//  MarvelHeros
//
//  Created by gustavo r meyer on 8/12/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import UIKit

class HeroesDataManager:HeroesDataManagerProtocol {
    
    //MARK: - Network Service
    let marvelServiceApi:MarvelServiceAPIProtocol
    
    //MARK: - Attributes
    private var characteres = [Character]()
    private var ids = [Int]()
    
    private var currentPage: Int = 0
    private var offset: Int = 20
    
    private var totalPages: Int = 0
    private var totalItems: Int = 0
    
    private var hasLoaded = false
    private var fetchPageInProgress = false
    private var refreshFeedInProgress = false
    
    
    init(marvelServiceApi:MarvelServiceAPIProtocol) {
        self.marvelServiceApi = marvelServiceApi
    }
    
    func numberOfItemsInFeed() -> Int {
        return characteres.count
    }
    
    func object(at index: Int) -> Character {
        return characteres[index]
    }
    
    func clear() {
        characteres = [Character]()
        ids = [Int]()
        
        currentPage = 0
        fetchPageInProgress = false
        refreshFeedInProgress = false
    }
    
    func requestPage(completeHandler:@escaping completeHandler, warningHandler: @escaping warningHandler, errorHandler:@escaping errorHandler) {
        guard !fetchPageInProgress else { return }
        
        fetchPageInProgress = true
        
        loadDataFromServer(replacingData: false, completeHandler: completeHandler, warningHandler: warningHandler, errorHandler: errorHandler)
    }
    
    func refresh(completeHandler:@escaping completeHandler, warningHandler: @escaping warningHandler, errorHandler:@escaping errorHandler ) {
        guard !refreshFeedInProgress else { return }
        
        refreshFeedInProgress = true
        currentPage = 0
        loadDataFromServer(replacingData: true, completeHandler: { character in
            completeHandler(character)
            self.refreshFeedInProgress = false
        }, warningHandler: warningHandler, errorHandler: errorHandler)

    }
    
    func loadDataFromServer(replacingData: Bool, completeHandler:@escaping completeHandler, warningHandler: @escaping warningHandler, errorHandler:@escaping errorHandler){
        
        let nextPage = self.currentPage * self.offset
        
        var newCharacteres = [Character]()
        var newIDs    = [Int]()

        marvelServiceApi.getCharacteres(offset: Int(nextPage),
            charactersCompleteHandler: { [weak self] responseCharacters in
                guard let strongSelf = self else { return }
                
                if ((responseCharacters.data?.results?.count)! > 0){
                    
                    
                    strongSelf.currentPage += 1
                    
                    for characater in (responseCharacters.data?.results)! {
                        if  !strongSelf.ids.contains(characater.id!) {
                            newCharacteres.append(characater)
                            newIDs.append(characater.id!)
                        }

                    }
                    
                }
                
                DispatchQueue.main.async {  [weak self] message in
                    guard let strongSelf = self else { return }
                    
                    if replacingData {
                        
                        strongSelf.characteres = newCharacteres
                        strongSelf.ids = newIDs
                    } else {
                        strongSelf.characteres.append(contentsOf: newCharacteres)
                        strongSelf.ids.append(contentsOf: newIDs)
                    }
                    completeHandler(newCharacteres)
                    strongSelf.hasLoaded = true
                    strongSelf.fetchPageInProgress = false
                }
            
            }, warningCompleteHandler: { message in
    
                DispatchQueue.main.async {
                    warningHandler(message)
                }
                
            }, errorCompleteHandler: { error in
                DispatchQueue.main.async {
                    errorHandler(error)
                }
                
        })
    
    }
}
