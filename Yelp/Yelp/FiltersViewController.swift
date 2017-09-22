//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Harsh Mehta on 9/21/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var filtersTableView: UITableView!
    
    let sections = ["Distance", "Sort By", "Category"]
    let data0 = ["0.3 miles", "1 miles", "5 miles", "20 miles"]
    let data1 = ["Best Match", "Distance", "Highest Rated"]
    let data2 = SearchFilters.categoriesTypes.map {
        $0["name"]!
    }
    
    var sectionData: [[String]] = []
    
    @IBAction func onCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onSave(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filtersTableView.delegate = self
        filtersTableView.dataSource = self

        sectionData = [data0, data1, data2]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FiltersCell", for: indexPath) as! FiltersCell
        
        let name = sectionData[indexPath.section][indexPath.row] as String
        cell.filterLabel.text = name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionData[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionData.count
    }
    

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FiltersHeaderView") as! FiltersHeaderView
        header.filterLabel.text = sections[section]
        return header
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    

}
