//
//  ViewModelProtocols.swift
//  TestApp
//
//  Created by Keyhan on 5/19/19.
//  Copyright © 2019 Keyhan. All rights reserved.
//

import Foundation

// MARK: - Resource View Model Delegate
protocol ResourcesViewModelDelegate: class {
    func onFetchCompleted()
    func onFetchFailed(with reason: String)
}

// MARK: - Categories View Model Delegate
protocol CategoriesViewModelDelegate: class {
    func onFetchCompleted()
    func onFetchFailed(with reason: String)
}
