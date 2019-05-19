//
//  ResourceDetailVC.swift
//  TestApp
//
//  Created by Keyhan on 5/18/19.
//  Copyright © 2019 Keyhan. All rights reserved.
//

import UIKit

class ResourceDetailVC: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var sundayBizHour: UILabel!
    @IBOutlet weak var mondayBizHour: UILabel!
    @IBOutlet weak var phoneBtn: UIButton!
    @IBOutlet weak var faxBtn: UIButton!
    @IBOutlet weak var emailBtn: UIButton!
    @IBOutlet weak var siteBtn: UIButton!
    @IBOutlet weak var twitterBtn: UIButton!
    @IBOutlet weak var utubeBtn: UIButton!
    
    // MARK: - Private Variables
    private var viewModel: ResourceDetailViewModel!
    
    // MARK: - Public Variables
    public var resource: Resource?

    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let resource = resource else {
            return
        }
        
        // init viewModel
        viewModel = ResourceDetailViewModel(resource: resource)
        
        // Update UI
        titleLbl.text = viewModel.title
        descriptionLbl.attributedText = viewModel.description
        addressLbl.text = viewModel.address
        sundayBizHour.text = viewModel.sundayWorkHour
        mondayBizHour.text = viewModel.mondayWorkHour
        
    }
    
    // MARK: - View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Remove navigation bar border and background
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // MARK: - Actions
    @IBAction func linkBtnTapped(_ sender: UIButton) {
        switch sender.tag {
        case 100:
            if sender.isEqual(phoneBtn) {
                guard let number = URL(string: "tel://\(viewModel.phoneNum ?? "")") else { return }
                UIApplication.shared.open(number)
            }
        case 101:
            if sender.isEqual(faxBtn) {
                guard let number = URL(string: "tel://\(viewModel.faxNum ?? "")") else { return }
                UIApplication.shared.open(number)
            }
        case 102:
            if sender.isEqual(emailBtn) {
                guard let number = URL(string: "mailto:\(viewModel.email ?? "")") else { return }
                UIApplication.shared.open(number)
            }
        case 103:
            if sender.isEqual(twitterBtn) {
                guard let number = URL(string: "\(viewModel.twitterAcc ?? "")") else { return }
                UIApplication.shared.open(number)
            }
        case 104:
            if sender.isEqual(utubeBtn) {
                guard let number = URL(string: "\(viewModel.youtubeAcc ?? "")") else { return }
                UIApplication.shared.open(number)
            }
        case 105:
            if sender.isEqual(siteBtn) {
                guard let number = URL(string: "\(viewModel.webSite ?? "")") else { return }
                UIApplication.shared.open(number)
            }
        default:
            break
        }
    }
    
    // MARK: - UITableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                
                guard let latitude = viewModel.latitude, let longitude = viewModel.longitude else {
                    return
                }
                
                guard let lat = Double(latitude), let lon = Double(longitude) else {
                    return
                }
                
                guard let url = URL(string: "http://maps.apple.com/maps?saddr=&?daddr=\(lat),\(lon)&dirflg=d") else {
                    return
                }
                UIApplication.shared.open(url)
            }
        }
    }
}
