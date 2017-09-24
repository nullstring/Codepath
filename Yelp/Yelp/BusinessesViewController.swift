//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var businessSearchBar: UISearchBar!
    @IBOutlet weak var businessesTableView: UITableView!
    var businesses: [Business] = []
    var filteredBusinesses: [Business] = []

    var dealFilter = DealFilter()
    var distanceFilter: DistanceFilter = .M0_3
    var sortByFilter: SortByFilter = .BestMatch
    var categoryFilter = CategoryFilter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSearchBar()
        
        businessesTableView.dataSource = self
        businessesTableView.delegate = self
        businessesTableView.rowHeight = UITableViewAutomaticDimension
        businessesTableView.estimatedRowHeight = 200
        

        
        filteredBusinesses = businesses
        
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses!
            self.filteredBusinesses = businesses!
            
            self.businessesTableView.reloadData()
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            
            }
        )
        
        /* Example of Yelp search with more search options specified
        Business.searchWithTerm(term: "Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
           print(business.name!)
           print(business.address!)
         }
        }
        */
 
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredBusinesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessTableViewCell", for: indexPath) as! BusinessTableViewCell
        cell.business = filteredBusinesses[indexPath.row]
        return cell
    }
    
    // MARK: - Search bar
    fileprivate func loadSearchBar() {
        businessSearchBar = UISearchBar()
        businessSearchBar.sizeToFit()
        businessSearchBar.delegate = self
        navigationItem.titleView = businessSearchBar
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        businessSearchBar.showsCancelButton = false
        businessSearchBar.text = ""
        businessSearchBar.endEditing(true)
        filteredBusinesses = businesses
        businessesTableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        businessSearchBar.showsCancelButton = true
    }
    
    // This method updates filteredData based on the text in the
    // Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredBusinesses = searchText.isEmpty ? businesses : businesses.filter { (item: Business) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.name!.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        businessesTableView.reloadData()
    }
    
    
     // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "FiltersViewControllerSegue" {
            let filterNavigationVC = segue.destination as! UINavigationController
            let filtersVC = filterNavigationVC.topViewController as! FiltersViewController
            
            filtersVC.dealFilter = dealFilter
            filtersVC.distanceFilter = distanceFilter
            filtersVC.sortByFilter = sortByFilter
            filtersVC.categoryFilter = categoryFilter
            filtersVC.onSaveButtonPressed = { (filtersVC: FiltersViewController) -> Void in
                self.dealFilter = filtersVC.dealFilter
                self.distanceFilter = filtersVC.distanceFilter
                self.sortByFilter = filtersVC.sortByFilter
                self.categoryFilter = filtersVC.categoryFilter
                Business.searchWithTerm(term: "", sort: filtersVC.sortByFilter.getYelpSortMode(), categories: Array(filtersVC.categoryFilter.selectedCategoryCodes), deals: filtersVC.dealFilter.selected, radius: filtersVC.distanceFilter.getDistanceInMeters(), completion: { (businesses: [Business]?, error: Error?) -> Void in
                    self.businesses = businesses!
                    self.filteredBusinesses = businesses!
                    
                    self.businessesTableView.reloadData()
                    if let businesses = businesses {
                        for business in businesses {
                            print(business.name!)
                            print(business.address!)
                        }
                    }
                    
                }
                )
            }
        }
    }
    
    
}
