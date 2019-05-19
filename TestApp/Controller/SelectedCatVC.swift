//
//  SelectedCatVC.swift
//  TestApp
//
//  Created by Keyhan on 5/18/19.
//  Copyright © 2019 Keyhan. All rights reserved.
//

import UIKit

class ResourcesVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortBtn: UIButton!
    @IBOutlet weak var searchTxtField: CustomTextField!
    @IBOutlet weak var searchBtn: UIButton!
    
    // MARK: - Private Variables
    private var viewModel: ResourcesViewModel!
    
    // MARK: - Public Variables
    public var resourceType: ResourceType!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set navigation bar title based on selected resource type
        if resourceType == .restaurants {
            navigationItem.title = "Restaurants"
        } else if resourceType == .vacation {
            navigationItem.title = "Vacation Spot"
        }
        
        viewModel = ResourcesViewModel(delegate: self)
        
        // Show a loading and fetch data
        self.startActivityIndicator()
        self.viewModel.fetchRestaurants(resType: resourceType)

        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ResourcesVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedCatCell", for: indexPath) as? SelectedCatCell else {
            return SelectedCatCell()
        }
        
        return cell
    }
}

extension ResourcesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 227
    }
}

extension ResourcesVC: ResourcesViewModelDelegate {
    func onFetchCompleted() {
        tableView.reloadData()
        self.stopActivityIndicator()
    }
    
    func onFetchFailed(with reason: String) {
        // Show alert to user
        self.stopActivityIndicator()
        print(reason)
    }
}
