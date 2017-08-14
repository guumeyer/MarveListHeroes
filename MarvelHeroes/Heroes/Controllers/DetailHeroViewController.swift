//
//  DetailHeroViewController.swift
//  MarvelHeros
//
//  Created by gustavo r meyer on 8/13/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import UIKit

class DetailHeroViewController: UIViewController {

    var hero:Character?
    
    var cells = ["profile", "name", "detail","comics", "events","series"]
    
    //ImageViewTableViewCell
    
    //MARK: - IBOutlets
    @IBOutlet weak var heroDetailTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = hero?.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        heroDetailTableView.delegate = self
        heroDetailTableView.dataSource = self

        heroDetailTableView.tableHeaderView = UIView()
        heroDetailTableView.tableFooterView = UIView()
        heroDetailTableView.backgroundColor = UIColor.white
        heroDetailTableView.separatorColor = UIColor.white
        heroDetailTableView.allowsSelection = false
        heroDetailTableView.separatorStyle = .none
        
        heroDetailTableView.rowHeight = UITableViewAutomaticDimension
        heroDetailTableView.estimatedRowHeight = 140
        
        heroDetailTableView.reloadData()
        // Do any additional setup after loading the view.
    }

    
}

extension DetailHeroViewController: UITableViewDataSource, UITableViewDelegate{
    
    func getIdentifierByIndex(index:Int) -> String {
        
        switch index {
        case 0:
            return "profileCell"
        default:
            return "detailCell"
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.cells.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: getIdentifierByIndex(index: indexPath.row))
        
        let cellName = cells[indexPath.row]
        
        switch cellName {
        case "profile":
            if let profileCell = cell as? ImageViewTableViewCell {
                profileCell.thumbnailImageView.image = hero?.image
            }
            
            break
        case "name":
            if let nameCell = cell as? DetailTableViewCell {
                
                nameCell.titleLabel.text = NSLocalizedString("Name", comment: "")
                nameCell.nameLabel.text = hero?.name
                nameCell.nameLabel.sizeToFit()
            }
            
            break
        case "detail":
            if let detailCell = cell as? DetailTableViewCell {
                
                detailCell.titleLabel.text = NSLocalizedString("Decription", comment: "")
                detailCell.nameLabel.text = hero?.description
                detailCell.nameLabel.sizeToFit()
            }
            break
        case "comics":
            if let comicsCell = cell as? DetailTableViewCell {
                comicsCell.titleLabel.text = NSLocalizedString("AmountComics", comment: "")
                comicsCell.nameLabel.text = "\(hero?.comics?.available ?? 0)"
                comicsCell.nameLabel.sizeToFit()
            }
            break
        case "events":
            if let comicsCell = cell as? DetailTableViewCell {
                comicsCell.titleLabel.text = NSLocalizedString("NumberOfParticipationsEvents", comment: "")
                comicsCell.nameLabel.text = "\(hero?.events?.available ?? 0)"
                comicsCell.nameLabel.sizeToFit()
            }
            break
        case"series":
            if let detailCell = cell as? DetailTableViewCell {
                
                detailCell.titleLabel.text = NSLocalizedString("NumberOfParticipationsSeries", comment: "")
                detailCell.nameLabel.text = "\(hero?.series?.available ?? 0)"
                detailCell.nameLabel.sizeToFit()
            }
            break
            
        default:
             break
        }
        
 
        return cell!
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 190
        }
        
        return UITableViewAutomaticDimension
    }
    
}
