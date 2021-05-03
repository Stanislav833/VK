//
//  AllGroupsTableViewController.swift
//  Weather
//
//  Created by Stanislav Vasilev on 08.03.2021.
//

import UIKit

class AllGroupsTableViewController: UITableViewController, UISearchBarDelegate {
    var groups = ["Авто",
            "Мото",
            "Подслушано",
            "Анекдоты",
            "Путешествия",
            "Здоровье",
            "Бокс",
            "Хоккей"
    ]
    var filteredGroups: [String]!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var selectedGroup: String?
    
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



