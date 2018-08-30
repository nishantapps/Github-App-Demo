//
//  FirstViewController.swift
//  Github App Demo
//
//  Created by Nishant Rai on 27/08/18.
//  Copyright © 2018 Nishant Rai. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    //MARK:Outlets
    
    @IBOutlet weak var dataSearch: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Variables
    
    var dataArray = [UserInformation]()
    var filteredArray = [String]()
    var searchController = UISearchController()
    var searching = false
    var userEnteredText = ""
    var baseUrlUser = "https://api.github.com/users/"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSearch.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        self.hideKeyboardWhenTappedAround()
      
    
    }
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searching = true
        tableView.reloadData()
        userEnteredText = baseUrlUser + searchText
        getNewMatchesData(urlpath: userEnteredText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }

    
    //MARK: Table View Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell") as! FirstTableViewCell
        let data = dataArray[indexPath.row]
        if searching {
            cell.userName.text = data.name
            var data1:Data?
            if let url = URL(string: data.avatar_url) {
                data1 = try? Data(contentsOf: url)
            }
            if let imageData = data1 {
                let image = UIImage(data: imageData)
                cell.userImage.image = image
            }
            
        }
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = dataArray[indexPath.row]
        let ViewController = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        ViewController.dataPassed = vc
        self.navigationController?.pushViewController(ViewController, animated: true)
        
    }
    
    
    //MARK: Networking and JSON Parsing
    func getNewMatchesData(urlpath: String){
        Alamofire.request(urlpath,
                          method: .get, encoding: JSONEncoding.default).responseJSON {
                            response in
                            if response.result.isSuccess {
                                
                                let userData: JSON = JSON(response.result.value!)
                                self.parseNewMatchesData(json: userData)
                                
                            }else {
                                print(response.result.error!)
                                
                            }
        }
        
    }
    
    
    func parseNewMatchesData(json:JSON) {
        
        var name1 = ""
        if json["name"] == JSON.null {
    
            name1 = json["login"].stringValue
        }
        else {
            name1 = json["name"].stringValue
        }
        
        let userData = UserInformation(login: json["login"].stringValue, id: json["id"].stringValue, avatar_url: json["avatar_url"].stringValue, url: json["url"].stringValue, followers_url: json["followers_url"].stringValue, following_url: json["following_url"].stringValue, gists_url: json["gists_url"].stringValue, starred_url: json["starred_url"].stringValue, subscriptions_url: json["subscriptions_url"].stringValue, organizations_url: json["organizations_url"].stringValue, repos_url: json["repos_url"].stringValue, name: name1 , blog: json["blog"].stringValue, bio: json["bio"].stringValue, public_repos: json["public_repos"].stringValue, followers: json["followers"].stringValue, following: json["following"].stringValue, created_at: json["created_at"].stringValue, updated_at: json["updated_at"].stringValue, public_gists: json["public_gists"].stringValue, location: json["location"].stringValue, email: json["email"].stringValue)
        dataArray.append(userData)
        
        self.tableView.reloadData()
        
        
    }
    
}

//MARK: Hiding Keyboard

extension FirstViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FirstViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}








