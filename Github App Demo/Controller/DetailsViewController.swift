//
//  DetailsViewController.swift
//  Github App Demo
//
//  Created by oms183 on 8/28/18.
//  Copyright © 2018 Nishant Rai. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Outlets
    var dataPassed : UserInformation?
    @IBOutlet var userProfilePicture: UIImageView!
    @IBOutlet var nameOfTheUser: UILabel!
    @IBOutlet var loginName: UILabel!
    
    
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet var following: UILabel!
    @IBOutlet var repositories: UILabel!
    @IBOutlet var publicGists: UILabel!
    @IBOutlet var tableView: UITableView!
    
    let SectionName = ["Bio", "Info"]
    let numberOfRowsAtSection: [Int] = [1, 3]
    let titleArray = ["Location", "E-mail", "Website"]
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        nameOfTheUser.text = dataPassed?.name
        loginName.text = dataPassed?.login
        followersLabel.text = dataPassed?.followers
        following.text = dataPassed?.following
        repositories.text = dataPassed?.public_repos
        publicGists.text = dataPassed?.public_gists
        
        var data:Data?
        if let url = URL(string: (dataPassed?.avatar_url)!){
            data = try? Data(contentsOf: url)
        }
        
        
        if let imageData = data {
            let image = UIImage(data: imageData)
            userProfilePicture.image = image
        }
        
    }
    
    //MARK: TableView Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows: Int = 0
        
        if section < numberOfRowsAtSection.count {
            rows = numberOfRowsAtSection[section]
        }
        
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BioCell") as! DetailsTableViewCell
            if (dataPassed?.bio.isEmpty)! {
                 cell.bioLabel.text = "Bio not available"
            }else{
                 cell.bioLabel.text = dataPassed?.bio
            }
           
            return cell
            
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell") as! InfoTableViewCell
            cell.title.text = titleArray[indexPath.row]
            cell.imageIcon.image = UIImage(named: titleArray[indexPath.row])
            if indexPath.row == 0{
                if (dataPassed?.location.isEmpty)!{
                    cell.value.text = "Location not available"
                }else{
                     cell.value.text = dataPassed?.location
                }
               
            }else if indexPath.row == 1 {
                if (dataPassed?.email.isEmpty)!{
                    cell.value.text = "email not available"
                }else{
                    cell.value.text = dataPassed?.email
                }
                cell.value.text = dataPassed?.email
            }else if indexPath.row == 2{
                if (dataPassed?.blog.isEmpty)!{
                    cell.value.text = "Website not available"
                }else{
                    cell.value.text = dataPassed?.blog
                }
                
            }
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionName.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section
        {
        case 0:
            return "Bio"
        case 1:
            return "Info"
        default:
            return ""
        }
    }
}


