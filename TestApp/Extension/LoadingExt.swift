//
//  LoadingExt.swift
//  TestApp
//
//  Created by Keyhan on 5/18/19.
//  Copyright © 2019 Keyhan. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

extension UIViewController {
    
    func startActivityIndicator(type: NVActivityIndicatorType = .ballScaleMultiple) {
        
        // Ensure the UI is updated from the main thread
        // in case this method is called from a closure
        DispatchQueue.main.async {
            
            // Create the activity indicator
            let activityData = ActivityData(size: CGSize(width: 80, height: 80), type: type, color: .blue, backgroundColor: .init(white: 0.4, alpha: 0.5))
            
            // Start animating
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        }
    }
    
    func stopActivityIndicator() {
        
        // Again, we need to ensure the UI is updated from the main thread!
        DispatchQueue.main.async { NVActivityIndicatorPresenter.sharedInstance.stopAnimating(NVActivityIndicatorView.DEFAULT_FADE_OUT_ANIMATION)
        }
    }
}
