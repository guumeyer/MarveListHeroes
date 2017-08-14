//
//  HerosListViewController.swift
//  MarvelHeros
//
//  Created by gustavo r meyer on 8/12/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import UIKit

class HeroesListViewController: UIViewController {

    //MARK: - Service
    var heroesDataManager:HeroesDataManagerProtocol?
    
    //MARK: - Attributes

    let screensFromBottomToLoadMoreCats: CGFloat = 2.5
    let alertTitle = NSLocalizedString("Welcome", comment: "")
    
    //MARK: - IBOutlets
    @IBOutlet weak var heroesTableView: UITableView!
    
    //MARK: - View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "logoMarvel")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        heroesTableView.delegate = self
        heroesTableView.dataSource = self

        heroesTableView.register(UINib(nibName: CharacterTableViewCell.Identifier, bundle: nil), forCellReuseIdentifier: CharacterTableViewCell.Identifier)
        
        refreshFeed()
        
        heroesTableView.tableHeaderView = UIView()
        heroesTableView.tableFooterView = UIView()
        heroesTableView.backgroundColor = UIColor.white
        heroesTableView.separatorColor = UIColor.white
        heroesTableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func refreshFeed() {
        
        self.showActivityIndicatory()
        heroesDataManager?.refresh(completeHandler:{ character in
            self.hideActivityIndicatory()
            self.insert(newRows: character)
            self.loadPage()
            
        }, warningHandler: {message in
            UIAlertController.showWarning(message: message, inViewController: self)
        }, errorHandler: {error in
            UIAlertController.showWarning(message: error.localizedDescription, inViewController: self)
            
        })
    }
    
    func loadPage() {
        heroesDataManager?.requestPage(completeHandler:{ character in
            //            self.activityIndicatorView.stopAnimating()
            self.insert(newRows: character)
        }, warningHandler: {message in
            UIAlertController.showWarning(message: message, inViewController: self)
        }, errorHandler: {error in
            UIAlertController.showWarning(message: error.localizedDescription, inViewController: self)
        
        })
    }
    
    func insert(newRows : [Character]) {
        //guard let postModels = postModels else { return }
        
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
