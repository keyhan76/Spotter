//
//  ResourceDetailRootVC.swift
//  TestApp
//
//  Created by Keyhan on 5/18/19.
//  Copyright © 2019 Keyhan. All rights reserved.
//

import UIKit

class ResourceDetailRootVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var resourceDetailVCView: CustomView!
    @IBOutlet weak var resourceImgView: UIImageView!
    
    // MARk: - Private Variables
    private var url: String!
    
    // MARk: - Public Variables
    public var resource: Resource?
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Download selected resource image
        guard let url = resource?.photo else {
            return
        }
        resourceImgView.loadImage(fromURL: url)
    }
    
    // MARK: - Prepare For Segue
    // Send resource data to child view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let desVC = destination as? ResourceDetailVC {
            desVC.resource = resource
            desVC.urlCallBack = { [unowned self] (url) in
                self.url = url
            }
        }
        
        if segue.identifier == "WebViewVC" {
            let desVC = segue.destination as! WebViewVC
            desVC.url = self.url
        }
    }

}
