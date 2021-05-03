//
//  FriendsViewController.swift
//  Weather
//
//  Created by Stanislav Vasilev on 07.03.2021.
//

import UIKit
import Alamofire

class FriendsTableViewController: UITableViewController {
    
    var friends = ["Иванов Илья", "Петров Дмитрий", "Покровский Евгений", "Димон", "Антоха", "Жека", "Маруся", "Света", "Михалыч", "Иваныч", "Автосервис", "Александр", "Рыбалкин", "Зеленый", "Сергей", "Евгений Гора", "Продавец", "Мария", "Виктория", "Маркус", "Рыбин", "Павел", "Сметана", "Телефоны", "Кирпич", "Лысый", "Лимон"]
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
    
    
}
