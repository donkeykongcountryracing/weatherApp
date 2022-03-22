//
//  TableViewController.swift
//  weatherApp
//
//  Created by Ethan  Jin  on 18/2/2022.
//

import UIKit



class TableViewController: UITableViewController, UISearchResultsUpdating {
    
    var filteredData: [Weather] = []
    
    var isSearchBarEmpty: Bool{
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, category: Weather.Type? = nil){
        
        filteredData = cities.filter{ (weather: Weather) -> Bool in //filtered data is an array and filter is a function that return a boolean which then filters the data array into the filtered data array
            return weather.city.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    
    var isFiltering: Bool{
        return searchController.isActive && !isSearchBarEmpty // is searchbar not empty
    }
    
    func getData(){
        guard let url = URL(string: "https://raw.githubusercontent.com/dbbudd/test_data/master/200USCities.json") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){
            (data, response, error) in
            
            guard let data = data else { return } // basically an if statement that checks whether if data can be the value of data. If not, the value either does not correspond with the data type or it is a nil. IN that situation it moves to the else and return nothing for the entire function because then continuing to run the code would be useless
            
            do {
                cities = try JSONDecoder().decode([Weather].self/* the value type that you want returned after puling from data*/, from: data)//return the value that you specify which is decoded from a JSON object. Basically updating each index of the cities array with the JSON that you pull from the website and pushing it as a type of Weather when you push it into the cities array
                print(cities.count)
            } catch _ {
                print(error as Any)
            }
    }
        task.resume() //calls on the task and runs the task. Sends the task request.
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        
        searchController.searchResultsUpdater = self // uiSearchResultsUpdating will no inform my class of any text changes within the search bar with this protocol
        searchController.obscuresBackgroundDuringPresentation = false // this should be true when you show a new viewController because you want to use another viewController to show and obscure the current view controller which contains the information your inputting. Since we set the current view to show the results, we don't want to cover the viewcontroller and the info and the view
        searchController.searchBar.placeholder = "Search Cities"
        navigationItem.searchController = searchController
        definesPresentationContext = true // this ensures that the search bar, which is part of the navigationItem of this current viewcontroller, does not transfer/remain on the search if a user segues into the another viewController while the UISearchController is still active. Since this covers the current viewController when navigating to a new one.
       
    }
    
    let searchController = UISearchController(searchResultsController: nil) // by having a nil value for searchResultsController you tell the controller that you want to use the same view you're searching to display the results, because normally the uisearchcontroller would display the results in a new viewController after searching the current controller
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }

    //sections is basically groups of rows
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return data.count // number of elements in the array
        if isFiltering {
            return filteredData.count
        }
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        for i in 0..<emoji.count {
            emoji[i].temp = Int.random(in: 10...23)
            switch emoji[i].temp {
            case 10..<12:
                emoji[i].description = "❄️"
                emoji[i].color = "3"
            case 12..<14:
                emoji[i].description = "🌨"
                emoji[i].color = "3"
            case 14..<15:
                emoji[i].description = "⛈"
                emoji[i].color = "4"
            case 15..<16:
                emoji[i].description = "🌧"
                emoji[i].color = "4"
            case 16..<18:
                emoji[i].description = "☁️"
                emoji[i].color = "5"
            case 18..<19:
                emoji[i].description = "🌦"
                emoji[i].color = "6"
            case 19..<20:
                emoji[i].description = "🌤"
                emoji[i].color = "6"
            case 20..<23:
                emoji[i].description = "☀️"
                emoji[i].color = "7"
            default:
                emoji[i].description = "☁️"
                emoji[i].color = "5"
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
        
        let newData: Weather // newData is a type with the value of the object "Weather"
        
        if isFiltering{
            newData = filteredData[indexPath.row]
        }
        else{
            newData = cities[indexPath.row]
        }
        
        cell.textLabel?.text = newData.city
        cell.detailTextLabel?.text = "Min: \(newData.min) Max: \(newData.max)"
        if indexPath.row == 27{
            cell.imageView?.image = UIImage(named: "LouisvilleJefferson County")
        }
        else{
            cell.imageView?.image = UIImage(named: newData.city)
        }
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor(named: "1")
        }
        else {
            cell.backgroundColor = UIColor(named: "2")
        }

        // Configure the cell...
//        cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
//        let cityData = data[indexPath.row]
//
//        cell.textLabel?.text = cityData.city + " " + cityData.description
//        cell.detailTextLabel?.text = "Max: \(cityData.max), Min: \(cityData.min)"
//
//        cell.imageView?.image = UIImage(named: cityData.city)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt IndexPath: IndexPath){
        
        selectedRow = IndexPath.row
        performSegue(withIdentifier: "transition", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.navigationItem.title = cities[selectedRow].city
    }

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
