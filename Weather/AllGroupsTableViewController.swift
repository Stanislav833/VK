//
//  AllGroupsTableViewController.swift
//  Weather
//
//  Created by Stanislav Vasilev on 08.03.2021.
//

import UIKit
import Alamofire
import AlamofireImage
import RealmSwift

class AllGroupsTableViewController: UITableViewController {
    
    /* var groups = ["Авто",
            "Мото",
            "Подслушано",
            "Анекдоты",
            "Путешествия",
            "Здоровье",
            "Бокс",
            "Хоккей"
    ]
    var filteredGroups: [String]! */
    
    @IBOutlet weak var searchBar: UISearchBar!
  
    
    var selectedGroup: String?
 /*
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        filteredGroups = groups
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filteredGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as!
            GroupTableViewCell
        cell.titleLable.text = filteredGroups[indexPath.row]
        return cell
    }
    
    // Mark: Search Bar Config
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredGroups = []
        
        if searchText == "" {
            filteredGroups = groups
        }
        else {
        
        for group in groups {
            if group.lowercased().contains(searchText.lowercased()) {
                filteredGroups.append(group)
            }
        }
        }
        self.tableView.reloadData()
    }
   
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedGroup = filteredGroups[indexPath.row]
        performSegue(withIdentifier: "addGroup", sender: self)
    }
}

*/
    
    var notificationGroups: NotificationToken?
    
    private var groups = [VKGroup]()
    private var filterGroups = [VKGroup]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self

        
        requestData()
        navigationItem.rightBarButtonItem = nil
        tableView.tableFooterView = UIView()
        
        notificationGroups = DataBaseService.instance.groups?.observe() { [unowned self] (changes) in
            print("notificationGroup>", changes)
            switch changes {
            case .initial(let groups):
                self.groups = groups.map { $0 }
                tableView.reloadData()

            case .update(let groups, _, _ , _):
                self.groups = groups.map { $0 }
                tableView.reloadData()
                
            case .error(_):
                print("error ")
            }
            
        }
        
        
        requestData()
    }
    

    private func requestData() {
        VKService.instance.loadGroups { result in
            switch result {
            case .success( _):
                print("success")
                
            case .failure(let error):
                print(error)
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterGroups.isEmpty ? groups.count : filterGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as!
        GroupTableViewCell
        let group = filterGroups.isEmpty ? groups[indexPath.row] : filterGroups[indexPath.row]
        let avatar = URL(string: group.avatar)!
        cell.titleLable.text = group.name
        cell.CommunityPhotosImageView.af.setImage(withURL: avatar)
        cell.CommunityPhotosImageView.setNeedsDisplay()
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let group = filterGroups.isEmpty ? groups[indexPath.row] : filterGroups[indexPath.row]
        selectedGroup = group.name
        performSegue(withIdentifier: "addGroup", sender: self)
        }
    
            
    
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return filterGroups.isEmpty ? true : false
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension AllGroupsTableViewController: UISearchBarDelegate  {
  
    
     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            clearSearch(searchBar)
            return
        }
        
        filterGroups = groups.filter { $0.name.lowercased().contains(searchText.lowercased()) }
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
        filterGroups = [VKGroup]()
    }
    
  

}
