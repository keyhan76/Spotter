//
//  ViewController.swift
//  TestApp
//
//  Created by Keyhan on 5/17/19.
//  Copyright © 2019 Keyhan. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private Variables
    private var viewModel: CategoryViewModel!

    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()

        // init viewModel
        viewModel = CategoryViewModel(delegate: self)
        
        // Show a loading and fetch data
        self.startActivityIndicator()
        self.viewModel.fetchCategories()
        
        // Setup tableview
        setupTableView()
    }
    
    // MARK: - View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Remove navigation bar border and background
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // MARKK: - Helpers
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        // Remove the last cell separator inset
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
    }
    
    // MARK: - Prepare For Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResourcesVC" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let desVC = segue.destination as! ResourcesVC
                
                // pass selected resources to the next vc
                if indexPath.row == 0 {
                    desVC.resourceType = .restaurants
                } else {
                   desVC.resourceType = .vacation
                }
            }
        }
    }
}

// MARK: - UITableView DataSource
extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else {
            return CategoryCell()
        }
        
        // Configure tableView cell
        cell.configureCell(with: viewModel.category(at: indexPath.row))
        
        return cell
    }
}

// MARK: - UITableView Delegate
extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 265.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ResourcesVC", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - CategoriesViewModel Delegate
extension HomeVC: CategoriesViewModelDelegate {
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
