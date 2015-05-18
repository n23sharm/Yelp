//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate, UISearchBarDelegate {
    
    var businesses: [Business]!
    var searchBar: UISearchBar!
    var searchSettings = BusinessSearchSettings()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colour = UIColor(red: 155.0/255.0, green: 1.0/255.0, blue: 1.0/255.0, alpha: 1.0)
        navigationController?.navigationBar.barTintColor = colour
        navigationController?.navigationBar.topItem?.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
        // initialize UISearchBar
        searchBar = UISearchBar()
        searchBar.tintColor = UIColor.whiteColor()
        searchBar.delegate = self
        
        // add search bar to navigation bar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        doSearch(nil, deal: false)

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
    }
    
    private func doSearch(categories: [String]?, deal: Bool?) {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        if (categories != nil) {
            Business.searchWithTerm(searchBar.text, sort: nil, categories: categories, deals: nil) { (businesses: [Business]!, error: NSError!) -> Void in
                self.businesses = businesses
                self.tableView.reloadData()
                MBProgressHUD.hideHUDForView(self.view, animated: true)
            }
        } else {
            NSLog(searchBar.text)
            Business.searchWithTerm(searchBar.text, completion: { (businesses: [Business]!, error: NSError!) -> Void in
                self.businesses = businesses
                self.tableView.reloadData()
                MBProgressHUD.hideHUDForView(self.view, animated: true)
            })
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        cell.business = businesses[indexPath.row]
        return cell
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        doSearch(nil, deal: false)
    }

    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as! UINavigationController
        let filtersViewController = navigationController.topViewController as! FiltersViewController
        filtersViewController.delegate = self
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilter filters: [String : AnyObject]) {
        var categories = filters["categories"] as? [String]
        var offerDeal = filters["deal"] as? Bool
        doSearch(categories, deal: offerDeal)
    }
}


extension BusinessesViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true;
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch(nil, deal: false)
    }
}
