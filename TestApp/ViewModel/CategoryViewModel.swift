//
//  CategoryViewModel.swift
//  TestApp
//
//  Created by Keyhan on 5/18/19.
//  Copyright © 2019 Keyhan. All rights reserved.
//

import Foundation

class CategoryViewModel {
    
    // MARK: - Private Variables
    private weak var delegate: CategoriesViewModelDelegate?
    private var isFetchInProgress = false
    private var categories: [Category] = []
    
    // MARK: - Public Varibles
    public var totalCount: Int {
        return categories.count
    }
    
    // MARK: - Initializer
    init(delegate: CategoriesViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Helprs
    func category(at index: Int) -> Category {
        return categories[index]
    }
    
    // MARK: - Network Call
    func fetchCategories() {
        
        // Check for avoiding multiple network calls
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        
        DataService.shared.getFeed(from: .categories, decodeType: Categories.self) { [unowned self] (result) in
            switch result {
            case .success(let category):
                self.isFetchInProgress = false
                
                // Append datas to categories array
                self.categories.append(contentsOf: category)
                
                // Notify the delegate
                self.delegate?.onFetchCompleted()
                
                print(self.categories)
            case .failure(let error):
                self.isFetchInProgress = false
                self.delegate?.onFetchFailed(with: error.localizedDescription)
            }
        }
    }
}
