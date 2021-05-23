//
//  FriendsViewController.swift
//  Weather
//
//  Created by Stanislav Vasilev on 07.03.2021.
//

import UIKit
import Alamofire

class FriendsTableViewController: UITableViewController {
    
    /* var friends = ["Иванов Илья", "Петров Дмитрий", "Покровский Евгений", "Димон", "Антоха", "Жека", "Маруся", "Света", "Михалыч", "Иваныч", "Автосервис", "Александр", "Рыбалкин", "Зеленый", "Сергей", "Евгений Гора", "Продавец", "Мария", "Виктория", "Маркус", "Рыбин", "Павел", "Сметана", "Телефоны", "Кирпич", "Лысый", "Лимон"]
    var images = [#imageLiteral(resourceName: "photo1"), #imageLiteral(resourceName: "avatar"), #imageLiteral(resourceName: "photo2"), #imageLiteral(resourceName: "photo3"), #imageLiteral(resourceName: "photo7"), #imageLiteral(resourceName: "photo10"), #imageLiteral(resourceName: "photo5"), #imageLiteral(resourceName: "photo7"), #imageLiteral(resourceName: "photo8"), #imageLiteral(resourceName: "photo2"), #imageLiteral(resourceName: "photo6"), #imageLiteral(resourceName: "photo5"), #imageLiteral(resourceName: "photo3"), #imageLiteral(resourceName: "photo1"), #imageLiteral(resourceName: "photo4"), #imageLiteral(resourceName: "photo7"), #imageLiteral(resourceName: "photo1"), #imageLiteral(resourceName: "photo3"), #imageLiteral(resourceName: "photo10"), #imageLiteral(resourceName: "photo8"), #imageLiteral(resourceName: "photo8"), #imageLiteral(resourceName: "photo8"), #imageLiteral(resourceName: "photo8"), #imageLiteral(resourceName: "photo8"), #imageLiteral(resourceName: "photo8"), #imageLiteral(resourceName: "photo8"), #imageLiteral(resourceName: "photo8")]
    var selectedFriend: String?
    var dictionary: [String: [String]] = [:]
    private var headReuseIdentifier = "FriendHeader"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AF.request("https://api.vk.com/method/friends.get",
                   parameters: [
                    "access_token" : Session.shared.token,
                    "user_id" : Session.shared.userId,
                    "order" : "name",
                    "fields" : "nickname",
                    "v" : "5.68"
                   ]).responseJSON {
                    response in
                    print(response.value)
                   }
        
        var dictionary: [String: [String]] = [:]
        friends.forEach {
        var value: [String] = []
            if let dictValue = dictionary[String($0.first!)] {
                value = dictValue
            }
            value.append($0)
            dictionary[String($0.first!)] = value
        }
        
        self.dictionary = dictionary
        
        tableView.register(UINib(nibName: "FriendsTableViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: headReuseIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(Array(dictionary.keys).sorted(by: <)[section]) "
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dictionary.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = Array(dictionary.keys).sorted(by: <)[section]
        return dictionary[key]?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as!
        FriendTableViewCell 
        let sectionName = Array(dictionary.keys).sorted(by: <)[indexPath.section]
        let friend = dictionary[sectionName]?.sorted(by: <)[indexPath.row]
        let image = images[indexPath.row]
        cell.titleLable.text = friend
        cell.icon.image = image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let sectionName = Array(dictionary.keys).sorted(by: <)[indexPath.section]
        selectedFriend = dictionary[sectionName]?.sorted(by: <)[indexPath.row]
        performSegue(withIdentifier: "toPhoto", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "toPhoto",
           let destination = segue.destination as? PhotoViewController {
            destination.title = selectedFriend
            
        }
    
   
    }
    */
    

    @IBOutlet weak var SearchBar: UISearchBar!
    
    var selectedFriend: String?
        private var filteredUsers = [VKUser]() {
            didSet {
                tableView.reloadData()
            }
        }
        
        private var userGroups = [String: [VKUser]]() {
            didSet {
                users = userGroups.flatMap { $0.value } .sorted { $0.lastName < $1.lastName }
                tableView.reloadData()
            }
        }
        
        private var users = [VKUser]()
        private var sectionTitles = [String]()
        
            override func viewDidLoad() {
                super.viewDidLoad()
                
                requestData()
                tableView.tableFooterView = UIView()
            }

       
        
            private func requestData() {
                VKService.instance.loadFriends { result in
                    switch result {
                    
                    case .success(let users):
                        self.users = users
                        self.tableView.reloadData()
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            return users.isEmpty ? sectionTitles.count : 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if users.isEmpty {
                let sectionTitle = sectionTitles[section]
                return userGroups[sectionTitle]?.count ?? 0
            } else {
                return users.count
            }
        }
       
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                 let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FriendTableViewCell
                
                var user: VKUser? = nil
                if users.isEmpty {
                    let sectionTitle = sectionTitles[indexPath.section]
                    user = userGroups[sectionTitle]?[indexPath.row]
                } else {
                    user = users[indexPath.row]
                }
            
                 let avatarUrl = URL(string: user!.avatarUrl)!
            cell.titleLable.text = String(format: "%@ %@", user!.firstName, user!.lastName)
            cell.icon.af.setImage(withURL: URL(string: user!.avatarUrl)!)
            cell.icon.setNeedsDisplay()
                 return cell
        }
       
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            performSegue(withIdentifier: "toPhoto", sender: self)
        }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            super.prepare(for: segue, sender: sender)
            if segue.identifier == "toPhoto",
               let destination = segue.destination as? PhotoViewController {
                destination.title = selectedFriend
            } else {
                return
            }

            
        }
    }

extension FriendsTableViewController: UISearchBarDelegate  {
  
    
     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            clearSearch(searchBar)
            return
        }
        
        filteredUsers = users.filter { $0.firstName.lowercased().contains(searchText.lowercased()) }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clearSearch(searchBar)
    }
    
    private func clearSearch(_ searchBar: UISearchBar) {
        searchBar.text = nil
        view.endEditing(true)
        filteredUsers = [VKUser]()
    }
    
  

}
