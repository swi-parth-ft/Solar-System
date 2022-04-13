//
//  FavDetailsViewController.swift
//  Solar
//
//  Created by Parth Antala on 2022-04-04.
//

import UIKit

class FavDetailsViewController: UIViewController, favProtocol {
    func favDetails(solar: SolarFav) {
        var favPlanetDetails = solar
    }
    

  
    

    @IBOutlet weak var gravity: UILabel!
    @IBOutlet weak var escape: UILabel!
    @IBOutlet weak var avgTemp: UILabel!
    @IBOutlet weak var density: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var bodyType: UILabel!
    @IBOutlet weak var englishName: UILabel!
    var engName: String = ""
    var bType: String = ""
    var grav: Double?
    var temp: Double?
    var dens: Double?
    var esc: Double?
    var nam: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        englishName.text! += engName
        bodyType.text! += bType
        gravity.text! += grav != nil ? String(grav!) : ""
        escape.text! += esc != nil ? String(esc!) : ""
        avgTemp.text! += temp != nil ? String(temp!) : ""
        density.text! += dens != nil ? String(dens!) : ""
        name.text! += nam
    }
    
    @IBAction func done(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    func addToFavClickedProtocol(planet:SolarFav) {
   
        print(planet)
      

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

