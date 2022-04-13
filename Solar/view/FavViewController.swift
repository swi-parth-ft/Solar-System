//
//  FavViewController.swift
//  Solar
//
//  Created by Parth Antala on 2022-04-04.
//

import UIKit
import CoreData

protocol favProtocol {
    func favDetails(solar : SolarFav)
   
}
class FavViewController: UITableViewController,UINavigationControllerDelegate {
   
    
    var delegate : favProtocol?
    var p:SolarFav?
  
    var allballs : [SolarFav] = [SolarFav]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allballs = CoreData.Shared.getAllDataFromStorage()
        tableView.reloadData()
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        allballs = CoreData.Shared.getAllDataFromStorage()
        tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allballs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = allballs[indexPath.row].englishName
        cell.detailTextLabel?.text = allballs[indexPath.row].bodyType
        
        return cell
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        p = allballs[indexPath.row]
        self.delegate?.favDetails(solar: p!)
        
    }
  
    //For remove row from tableview & object from array.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            CoreData.Shared.delete(delete: allballs[indexPath.row])
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "favDetails"){
        let ivc = segue.destination as! FavDetailsViewController
          
            ivc.engName = allballs[tableView.indexPathForSelectedRow!.row].englishName!
            ivc.bType = allballs[tableView.indexPathForSelectedRow!.row].bodyType!
            ivc.grav = allballs[tableView.indexPathForSelectedRow!.row].gravity
            ivc.temp = allballs[tableView.indexPathForSelectedRow!.row].avgTemp
            ivc.dens = allballs[tableView.indexPathForSelectedRow!.row].density
            ivc.esc = allballs[tableView.indexPathForSelectedRow!.row].escape
            ivc.nam = allballs[tableView.indexPathForSelectedRow!.row].name!

   
        }
    }
//

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
