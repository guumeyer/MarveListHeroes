//
//  DetailHeroViewController.swift
//  MarvelHeros
//
//  Created by gustavo r meyer on 8/13/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import UIKit

class DetailHeroViewController: UIViewController {

    //MARK: - Attributes
    var hero:Character?
    var cells = ["profile", "name", "detail","comics", "events","series"]

    //MARK: - IBOutlets
    @IBOutlet weak var heroDetailTableView: UITableView!
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = hero?.name
    }
    
    func setupView(){
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
    }
}

//MARK: - TableView Delegate and DataSource
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
             setupDetailTableViewCell(cell!, titleText: NSLocalizedString("Decription", comment: ""), description: (hero?.description)!)
            break
        case "comics":
             setupDetailTableViewCell(cell!, titleText: NSLocalizedString("AmountComics", comment: ""), description: "\(hero?.comics?.available ?? 0)")
            break
        case "events":
             setupDetailTableViewCell(cell!, titleText: NSLocalizedString("NumberOfParticipationsEvents", comment: ""),description: "\(hero?.events?.available ?? 0)")
            break
        case"series":

            setupDetailTableViewCell(cell!, titleText: NSLocalizedString("NumberOfParticipationsSeries", comment: ""),description: "\(hero?.series?.available ?? 0)")

            break
            
        default:
             break
        }
        
 
        return cell!
    }
    
    func setupDetailTableViewCell(_ cell:UITableViewCell, titleText:String, description:String){
        if let detailCell = cell as? DetailTableViewCell {
            detailCell.titleLabel.text = titleText
            detailCell.nameLabel.text = description
            detailCell.nameLabel.sizeToFit()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 190
        }
        
        return UITableViewAutomaticDimension
    }
    
}
