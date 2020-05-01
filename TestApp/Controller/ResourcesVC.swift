//
//  ResourcesVC.swift
//  TestApp
//
//  Created by Keyhan on 5/18/19.
//  Copyright © 2019 Keyhan. All rights reserved.
//


import UIKit

class ResourcesVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortBtn: UIButton!
    @IBOutlet weak var searchTxtField: CustomTextField!
    @IBOutlet weak var searchBtn: UIButton!
    
    // MARK: - Private Variables
    private var viewModel: ResourcesViewModel!
    private var sortType: SortType = .unordered
    
    // MARK: - Public Variables
    public var resourceType: ResourceType!
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set navigation bar title based on selected resource type
        if resourceType == .restaurants {
            navigationItem.title = "Restaurants"
        } else if resourceType == .vacation {
            navigationItem.title = "Vacation Spot"
        }
        
        // init viewModel
        viewModel = ResourcesViewModel(delegate: self)
        
        // Show a loading and fetch data
        self.startActivityIndicator()
        self.viewModel.fetchRestaurants(resType: resourceType)
        
        // Setup tablview
        setupTableView()
    }
    
    // MARK: - Actions
    @IBAction func sortBtnTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Sort By:", message: nil, preferredStyle: .actionSheet)
        
        // Sort DataSource from A-Z
        alert.addAction(UIAlertAction(title: "A-Z", style: .default, handler:{ [unowned self] (UIAlertAction)in
            self.sortBtn.setTitle("From A-Z", for: .normal)
            self.sortType = .a2z
            self.tableView.reloadData()
        }))
        
        // Sort DataSource from Z-A
        alert.addAction(UIAlertAction(title: "Z-A", style: .default, handler:{ [unowned self] (UIAlertAction)in
            self.sortBtn.setTitle("From Z-A", for: .normal)
            self.sortType = .z2a
            self.tableView.reloadData()
        }))
        
        // Sort DataSource unordered
        alert.addAction(UIAlertAction(title: "Unordered", style: .default, handler:{ [unowned self] (UIAlertAction)in
            self.sortBtn.setTitle("Unordered", for: .normal)
            self.sortType = .unordered
            self.tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Prepare For Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResourceDetailRootVC" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let desVC = segue.destination as! ResourceDetailRootVC
                desVC.resource = viewModel.resource(at: indexPath.row, sortType: sortType)
            }
        }
    }
    
    // MARK: - Helpers
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - UITableView DataSource
extension ResourcesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResourcesCell", for: indexPath) as? ResourcesCell else {
            return ResourcesCell()
        }
        
        // Configure cell based on resource and sort type
        cell.configureCell(resource: viewModel.resource(at: indexPath.row, sortType: sortType))
        
        return cell
    }
}

// MARK: - UITableView Delegate
extension ResourcesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 227
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ResourceDetailRootVC", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - CategoriesViewModel Delegate
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

