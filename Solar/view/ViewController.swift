//
//  ViewController.swift
//  Solar
//
//  Created by Parth Antala on 2022-03-31.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,
                      UITableViewDataSource,UISearchBarDelegate, UISearchResultsUpdating{
  
    var index = 0
    let searchController = UISearchController()
    @IBOutlet weak var SolarTable: UITableView!
    var result : BodyCollection = BodyCollection()
    var resultPlanets: BodyCollection = BodyCollection()
    var searchedPlanet: BodyCollection = BodyCollection()
    var count = 0
    var countPlanets = 0
    var x = 0
    override func viewDidLoad() {
        initSearchController()
        super.viewDidLoad()
        SolarTable.dataSource = self
        SolarTable.delegate = self
        SolarTable.reloadData()
       // Network.Shared.delegate = self
        // Do any additional setup after loading the view.
        getNewData()
        self.SolarTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = SolarTable.indexPathForSelectedRow {
            SolarTable.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }

    
    func initSearchController()
    {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.scopeButtonTitles = ["All", "Planet", "Moon", "asteroid", "comet"]
        searchController.searchBar.delegate = self
    }
  
    func getNewData()  {
        Network.Shared.getImagesDataFromURL() { resutl in
            switch resutl {
            case .success(let PlanetsCollection) :
                DispatchQueue.main.async { [self] in
                    self.result = PlanetsCollection
                   

                    print(countPlanets)
                    print(String( self.result.bodies.count))
                    print("start")
                    self.count = result.bodies.count
                    print(count)
                    SolarTable.reloadData()
                }
              
                break
            case .failure(_):
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchController.isActive)
        {
            return searchedPlanet.bodies.count
        }
     //  return countPlanets
        return result.bodies.count

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        var planet = resultPlanets.bodies
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)

       // cell.link = self
        print(indexPath.row)
      
        if(searchController.isActive)
        {
            cell.textLabel?.text = String(searchedPlanet.bodies[indexPath.row].englishName)
            cell.detailTextLabel?.text = String(searchedPlanet.bodies[indexPath.row].bodyType)
        
        }
        else
        {
            cell.textLabel?.text = String(result.bodies[indexPath.row].englishName)
            cell.detailTextLabel?.text = String(result.bodies[indexPath.row].bodyType)
    
            
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.index = indexPath.row
        self.performSegue(withIdentifier: "detailSegue", sender: self)
    
       }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(segue.identifier == "detailSegue")
        {
            let indexPath = self.SolarTable.indexPathForSelectedRow
            let tableViewDetail = segue.destination as? DetailViewController

            let selectedPlanet: Planets!

            if(searchController.isActive)
            {
                selectedPlanet = searchedPlanet.bodies[indexPath!.row]
              
            }
            else
            {
                selectedPlanet = result.bodies[indexPath!.row]
                
            }


            tableViewDetail!.selectedPlanet = selectedPlanet


        }
    }

    func updateSearchResults(for searchController: UISearchController)
    {
        let searchBar = searchController.searchBar
        let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text!
        
        filterForSearchTextAndScopeButton(searchText: searchText, scopeButton: scopeButton)
    }
    
    func filterForSearchTextAndScopeButton(searchText: String, scopeButton : String = "All")
    {
        searchedPlanet.bodies = result.bodies.filter
        {
            planet in
            let scopeMatch = (scopeButton == "All" || planet.bodyType.lowercased().contains(scopeButton.lowercased()))
            if(searchController.searchBar.text != "")
            {
                let searchTextMatch = planet.englishName.lowercased().contains(searchText.lowercased())
                
                return scopeMatch && searchTextMatch
            }
            else
            {
                return scopeMatch
            }
        }
        SolarTable.reloadData()
    }
    
    
}

