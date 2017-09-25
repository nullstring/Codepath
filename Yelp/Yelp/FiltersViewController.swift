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

    let sections = ["", "Distance", "Sort By", "Category"]
    var sectionExpanded = [false, false, false, false]

    let dealSectionIndex = 0
    let distanceSectionIndex = 1
    let sortBySectionIndex = 2
    let categorySectionIndex = 3

    var dealFilter = DealFilter()
    var distanceFilter: DistanceFilter = .M0_3
    var sortByFilter: SortByFilter = .BestMatch
    var categoryFilter = CategoryFilter()

    var onSaveButtonPressed: ((FiltersViewController) -> Void)?

    var sectionData: [[String]] = []

    @IBAction func onCancel(_: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onSave(_: Any) {
        onSaveButtonPressed!(self)
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        filtersTableView.delegate = self
        filtersTableView.dataSource = self

        sectionData = [[dealFilter.name], [distanceFilter.getDescription()], [sortByFilter.getDescription()], categoryFilter.categoryNameArray]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FiltersCell", for: indexPath) as! FiltersCell

        let section = indexPath.section
        let row = indexPath.row

        let name = sectionData[section][row] as String
        cell.filterLabel.text = name

        cell.switchToggled = { (cell, isSwitchedOn) -> Void in
            let indexPath = self.filtersTableView.indexPath(for: cell)!
            let section = indexPath.section
            switch section {
            case self.dealSectionIndex:
                self.dealFilter.selected = isSwitchedOn
            case self.categorySectionIndex:
                self.categoryFilter.categoryFor(categoryIndex: indexPath.row, isSwitchedOn: isSwitchedOn)
            default: break
            }
        }

        // If one of the exclusive list sections, hide the switch from the filters cell.
        switch section {
        case dealSectionIndex:
            cell.filterSwitch.isHidden = false
            cell.accessoryType = .none
            cell.filterSwitch.isOn = dealFilter.selected
        case distanceSectionIndex:
            cell.filterSwitch.isHidden = true
            cell.accessoryType = .checkmark
            if (!sectionExpanded[section]) || (sectionExpanded[section] && distanceFilter.rawValue == row) {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        case sortBySectionIndex:
            cell.filterSwitch.isHidden = true
            cell.accessoryType = .checkmark
            if (!sectionExpanded[section]) || (sectionExpanded[section] && sortByFilter.rawValue == row) {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        case categorySectionIndex:
            cell.filterSwitch.isHidden = false
            cell.accessoryType = .none
            cell.filterSwitch.isOn = categoryFilter.categorySwitchStatusFor(categoryIndex: row)
        default: break
        }
        return cell
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionData[section].count
    }

    func numberOfSections(in _: UITableView) -> Int {
        return sectionData.count
    }

    func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        switch section {
        case distanceSectionIndex:
            if sectionExpanded[section] {
                distanceFilter = DistanceFilter.getDistanceFilterForIndex(index: indexPath.row)
                sectionData[distanceSectionIndex] = [distanceFilter.getDescription()]
            } else {
                sectionData[distanceSectionIndex] = DistanceFilter.getOrderedDescriptions()
            }
        case sortBySectionIndex:
            if sectionExpanded[section] {
                sortByFilter = SortByFilter.getSortByFilterForIndex(index: indexPath.row)
                sectionData[sortBySectionIndex] = [sortByFilter.getDescription()]
            } else {
                sectionData[sortBySectionIndex] = SortByFilter.getOrderedDescriptions()
            }
        default: break
        }
        sectionExpanded[section] = !sectionExpanded[section]
        tableView.reloadSections(IndexSet([section]), with: .automatic)
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
