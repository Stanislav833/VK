//
//  News2TableViewController.swift
//  Weather
//
//  Created by Stanislav Vasilev on 06.06.2021.
//

import UIKit

class News2TableViewController: UITableViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.estimatedRowHeight = 100 // set to whatever your "average" cell height is
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
       tableView.rowHeight = UITableView.automaticDimension
        
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
  
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as! AutherDateTableViewCell
            cell1.autherLabel.text = "Илон Маск"
            cell1.dateLabel.text = "26.12.2020"
            // Set up cell.label
            return cell1
            
        } else if indexPath.row == 1 {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! TextNewsTableViewCell
            cell2.textNewsLabel.text = "Илон Маск вышел победителем из судебного  процесса по делу о клевете. Жюри присяжных  отклонило иск на $190 млн, поданный  британским дайвером Верноном Ансвортом,  сообщил Reuters. На принятие решения у  присяжных ушло 45 минут."
            // Set up cell.textField
            return cell2
            
        } else if indexPath.row == 2 {
            let cell3 = tableView.dequeueReusableCell(withIdentifier: "Cell3", for: indexPath) as! NewsPhotoTableViewCell
            cell3.newsPhoto.image = #imageLiteral(resourceName: "фотоНовость")
            // Set up cell.photo
            return cell3
            
        } else {
            let cell4 = tableView.dequeueReusableCell(withIdentifier: "Cell4", for: indexPath) as! NewsButtonsTableViewCell
            
            return cell4
        }
    }
    /*
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath)

        // Configure the cell...

        return cell
    }
    
    */

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
