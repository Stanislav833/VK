//
//  GroupsTableViewController.swift
//  Weather
//
//  Created by Stanislav Vasilev on 08.03.2021.
//

import UIKit
import Alamofire

class GroupsTableViewController: UITableViewController {
    var groups = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AF.request("https://api.vk.com/method/groups.get",
                   parameters: [
                    "access_token" : Session.shared.accessToken,
                    "user_id" : Session.shared.userId,
                    "extended" : "1",
                    "fields" : "city, description, members_counts",
                    "v" : "5.68"
                   ]).responseJSON {
                    response in
                    print(response.value)
                   }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as!
            GroupTableViewCell
        let group = groups[indexPath.row]
        cell.titleLable.text = group
        return cell
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue){
        if segue.identifier == "addGroup",
           let sourceVC = segue.source as? AllGroupsTableViewController,
           let selectedGroup = sourceVC.selectedGroup {
            //Добавляем выбранную группу
            if !groups.contains(selectedGroup) {
                groups.append(selectedGroup)
                tableView.reloadData()
            }
        }
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}


