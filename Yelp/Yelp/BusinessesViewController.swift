//
//  BusinessesViewController.swift
//  Yelp
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIScrollViewDelegate {

    var businessSearchBar: UISearchBar!
    @IBOutlet weak var businessesTableView: UITableView!
    var businesses: [Business] = []
    var filteredBusinesses: [Business] = []

    var term: String = "Restaurants"
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

        setupInfiniteScrollView()

        reloadData(withOffset: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return filteredBusinesses.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessTableViewCell", for: indexPath) as! BusinessTableViewCell
        cell.business = filteredBusinesses[indexPath.row]
        return cell
    }

    // MARK: - Infinite scroll
    var isLoading = false
    var loadingMoreViews: InfiniteScrollActivityView?

    fileprivate func setupInfiniteScrollView() {
        // Setup infinite scroll view.
        let infiniteScrollViewFrame = CGRect(x: 0, y: businessesTableView.contentSize.height, width: businessesTableView.contentSize.width, height: InfiniteScrollActivityView.defaultHeight)
        loadingMoreViews = InfiniteScrollActivityView(frame: infiniteScrollViewFrame)
        loadingMoreViews!.isHidden = true
        businessesTableView.addSubview(loadingMoreViews!)

        var insets = businessesTableView.contentInset
        insets.bottom += InfiniteScrollActivityView.defaultHeight
        businessesTableView.contentInset = insets
    }

    // MARK: - Search bar
    fileprivate func loadSearchBar() {
        businessSearchBar = UISearchBar()
        businessSearchBar.sizeToFit()
        businessSearchBar.delegate = self
        navigationItem.titleView = businessSearchBar
    }

    func searchBarCancelButtonClicked(_: UISearchBar) {
        businessSearchBar.showsCancelButton = false
        businessSearchBar.text = ""
        businessSearchBar.endEditing(true)
        filteredBusinesses = businesses
        businessesTableView.reloadData()
    }

    func searchBarTextDidBeginEditing(_: UISearchBar) {
        businessSearchBar.showsCancelButton = true
    }

    // This method updates filteredData based on the text in the
    // Search Box
    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredBusinesses = searchText.isEmpty ? businesses : businesses.filter { (item: Business) -> Bool in
            // If dataItem matches the searchText, return true to include it
            item.name!.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }

        businessesTableView.reloadData()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isLoading {
            return
        }
        // Fire a network request one screen before content ends.
        let scrollViewContentHeight = businessesTableView.contentSize.height
        let scrollOffsetThreshhold = scrollViewContentHeight - businessesTableView.bounds.size.height

        if scrollView.contentOffset.y > scrollOffsetThreshhold && businessesTableView.isDragging {
            isLoading = true

            let infiniteScrollViewFrame = CGRect(x: 0, y: businessesTableView.contentSize.height, width: businessesTableView.contentSize.width, height: InfiniteScrollActivityView.defaultHeight)
            loadingMoreViews!.frame = infiniteScrollViewFrame
            loadingMoreViews!.startAnimating()

            reloadData(withOffset: filteredBusinesses.count)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
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
                self.reloadData(withOffset: 0)
            }
        }
    }

    func reloadData(withOffset: Int) {
        Business.searchWithTerm(term: term, sort: sortByFilter.getYelpSortMode(), categories: Array(categoryFilter.selectedCategoryCodes), deals: dealFilter.selected, radius: distanceFilter.getDistanceInMeters(), offset: withOffset, completion: { (retrivedBusinesses: [Business]?, _: Error?) -> Void in
            var businesses: [Business] = []
            if retrivedBusinesses != nil {
                businesses = retrivedBusinesses!
            }

            self.filteredBusinesses.removeLast(self.filteredBusinesses.count - withOffset)
            self.filteredBusinesses.append(contentsOf: businesses)

            self.businesses = self.filteredBusinesses

            self.businessesTableView.reloadData()
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
            self.isLoading = false
            self.loadingMoreViews!.stopAnimating()
        }
        )
    }
}
