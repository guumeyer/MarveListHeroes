//
//  HerosListViewController.swift
//  MarvelHeros
//
//  Created by gustavo r meyer on 8/12/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import UIKit
import ReachabilitySwift

class HeroesListViewController: UIViewController {

    //MARK: - Service
    var heroesDataManager:HeroesDataManagerProtocol?
    
    //MARK: - Attributes
    let reachability = Reachability()!
    var isReachable = true
    let screensFromBottomToLoadMoreCats: CGFloat = 2.5
    let alertTitle = NSLocalizedString("Welcome", comment: "")
    
    //MARK: - IBOutlets
    @IBOutlet weak var heroesTableView: UITableView!
    
    //MARK: - View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {

        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged),name: ReachabilityChangedNotification,object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self,
                                                  name: ReachabilityChangedNotification,
                                                  object: reachability)
    }
    
    //MARK: - Functions
    func setupView(){
        let logo = UIImage(named: "logoMarvel")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        heroesTableView.delegate = self
        heroesTableView.dataSource = self
        
        heroesTableView.register(UINib(nibName: CharacterTableViewCell.Identifier, bundle: nil), forCellReuseIdentifier: CharacterTableViewCell.Identifier)
        
        refresh()
        
        heroesTableView.tableHeaderView = UIView()
        heroesTableView.tableFooterView = UIView()
        heroesTableView.backgroundColor = UIColor.white
        heroesTableView.separatorColor = UIColor.white
        heroesTableView.separatorStyle = .none
    }
    
    func checkNetworkAvailable() -> Bool{
        if !isReachable{
            UIAlertController.showWarning(message: NSLocalizedString("NetworkNotReachable", comment: ""), inViewController: self)
        }
        
        return isReachable
    }
    
    func refresh() {
        
        if !checkNetworkAvailable() {
            return
        }
        
        self.showActivityIndicatory()
        heroesDataManager?.refresh(completeHandler:{ character in
            self.hideActivityIndicatory()
            self.insert(newRows: character)
            self.loadPage()
            
        }, warningHandler: {message in
            UIAlertController.showWarning(message: message, inViewController: self)
        }, errorHandler: {error in
            UIAlertController.showError(message: error.localizedDescription, inViewController: self)
            
        })
    }
    
    func loadPage() {
        
        if !checkNetworkAvailable() {
            return
        }
        
        heroesDataManager?.requestPage(completeHandler:{ character in
            self.insert(newRows: character)
        }, warningHandler: {message in
            UIAlertController.showWarning(message: message, inViewController: self)
        }, errorHandler: {error in
            UIAlertController.showError(message: error.localizedDescription, inViewController: self)
        
        })
    }
    
    func insert(newRows : [Character]) {

        var indexPaths = [IndexPath]()
        
        let newTotal = self.heroesDataManager?.numberOfItemsInFeed() ?? 0
        for i in (newTotal - newRows.count)..<newTotal {
            indexPaths.append(IndexPath(row: i, section: 0))
        }
        heroesTableView.insertRows(at: indexPaths, with: .none)
    }
    
    func showCharacterDetail(character:Character){
    
        let detailController = self.storyboard?.instantiateViewController(withIdentifier: "detailVIew") as! DetailHeroViewController
        
        detailController.hero = character
        
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
    //MARK: - Communication Monitor  
    func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        self.isReachable = reachability.isReachable
        
        if isReachable {
            if reachability.isReachableViaWiFi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        } else {
            print("Network not reachable")
        }
    }
}

extension HeroesListViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
        let character = self.heroesDataManager?.object(at: indexPath.row)
        
        showCharacterDetail(character: character!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.heroesDataManager!.numberOfItemsInFeed()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.Identifier) as! CharacterTableViewCell
        
        cell.layer.borderColor = UIColor.white.cgColor
        cell.backgroundColor = UIColor.white
        cell.character = self.heroesDataManager?.object(at: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let screensFromBottom = (scrollView.contentSize.height - scrollView.contentOffset.y)/UIScreen.main.bounds.size.height;
        
        if screensFromBottom < screensFromBottomToLoadMoreCats {
            loadPage()
        }
    }
}
