//
//  AppDelegate.swift
//  MarvelHeros
//
//  Created by gustavo r meyer on 8/12/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import UIKit

@UIApplicationMain
    class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let rootController  = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! HeroesListViewController

        rootController.heroesDataManager = HeroesDataManager(marvelServiceApi:  MarvelServiceAPI())
        
        window?.rootViewController = UINavigationController(rootViewController: rootController)
        
        application.statusBarStyle = .lightContent
     
        defineNavegationBarStyle()
        
      
        return true
    }
    
    func defineNavegationBarStyle(){
        UINavigationBar.appearance().barTintColor = UIColor.red//(red:255/243, green: 255/11, blue: 255/10, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
    }
}

