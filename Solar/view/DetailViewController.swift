//
//  DetailViewController.swift
//  Solar
//
//  Created by Parth Antala on 2022-03-31.
//

import UIKit

class DetailViewController: UIViewController {
   
    
   
    

    var selectedPlanet : Planets!
  
    @IBAction func addToFavClicked(_ sender: Any) {
        let englishName = selectedPlanet.englishName
        var bodyType = selectedPlanet.bodyType
        let name = selectedPlanet.name
        let gravity = selectedPlanet.gravity!
        let avgTemp = selectedPlanet.avgTemp!
        let escape = selectedPlanet.escape!
        let density = selectedPlanet.density!
       
        
        CoreData.Shared.insertDataIntoStorage(englishName: englishName, bodyType: bodyType, name: name, gravity: gravity, density: density, escape: escape, avgTemp: avgTemp)
        self.dismiss(animated: true, completion: nil)
       
        
    }
    
    @IBOutlet weak var gravity: UILabel!
    @IBOutlet weak var escape: UILabel!
    @IBOutlet weak var density: UILabel!
    @IBOutlet weak var avgTemp: UILabel!
    @IBOutlet weak var bodyType: UILabel!
    @IBOutlet weak var englishName: UILabel!
    @IBOutlet weak var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text! += selectedPlanet.name
        englishName.text! += selectedPlanet.englishName
        bodyType.text! += selectedPlanet.bodyType
        gravity.text! += selectedPlanet.gravity != nil ? String(selectedPlanet.gravity!) : ""
        avgTemp.text! += selectedPlanet.avgTemp != nil ? String(selectedPlanet.avgTemp!) : ""
        escape.text! += selectedPlanet.escape != nil ? String(selectedPlanet.escape!) : ""
        density.text! += selectedPlanet.density  != nil ? String(selectedPlanet.density!) : ""
       
        
    }
    
    @IBAction func done(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
