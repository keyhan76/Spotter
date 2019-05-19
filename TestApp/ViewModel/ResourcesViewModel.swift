//
//  ResourcesViewModel.swift
//  TestApp
//
//  Created by Keyhan on 5/18/19.
//  Copyright © 2019 Keyhan. All rights reserved.
//

import Foundation

class ResourcesViewModel {
    // MARK: - Private Variables
    private weak var delegate: ResourcesViewModelDelegate?
    private var isFetchInProgress = false
    private var resources: [Resource] = []
    
    // MARK: - Public Varibles
    public var totalCount: Int {
        return resources.count
    }
    
    // MARK: - Initializer
    init(delegate: ResourcesViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Helprs
    func resource(at index: Int, sortType: SortType) -> Resource {
        switch sortType {
        case .a2z: // Sort the array from A-Z
            return resources.sorted { $0.title < $1.title }[index]
        case .z2a: // Sort the array from Z-A
          return resources.sorted { $0.title > $1.title }[index]
        case .unordered: // Sort the array from with default sort from server
            return resources[index]
        }
    }
    
    // MARK: - Network Call
    func fetchRestaurants(resType: ResourceType) {
        
        // Check for avoiding multiple network calls
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        
        DataService.shared.getFeed(from: resType, decodeType: Resources.self) { [unowned self] (result) in
            switch result {
            case .success(let resource):
                self.isFetchInProgress = false
                
                // Append datas to categories array
                self.resources.append(contentsOf: resource)
                
                // Notify the delegate
                self.delegate?.onFetchCompleted()
                
                print(self.resources)
            case .failure(let error):
                self.isFetchInProgress = false
                self.delegate?.onFetchFailed(with: error.localizedDescription)
            }
        }
    }
}
