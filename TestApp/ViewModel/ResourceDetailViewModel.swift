//
//  ResourceDetailViewModel.swift
//  TestApp
//
//  Created by Keyhan on 5/18/19.
//  Copyright © 2019 Keyhan. All rights reserved.
//

import Foundation

struct ResourceDetailViewModel {

    let address: String?
    let description: NSAttributedString
    let title: String
    let phoneNum: String?
    let email: String?
    let webSite: String?
    let sundayWorkHour: String?
    let mondayWorkHour: String?
    let twitterAcc: String?
    let facebookAcc: String?
    let youtubeAcc: String?
    let faxNum: String?
    let latitude: String?
    let longitude: String?

    // Dependency Injection (DI)
    init(resource: Resource) {
        self.title = resource.title
        self.phoneNum = resource.contactInfo.phoneNumber?.first
        self.email = resource.contactInfo.email?.first
        self.webSite = resource.contactInfo.website?.first
        self.faxNum = resource.contactInfo.faxNumber?.first
        
        self.twitterAcc = resource.socialMedia?.twitter?.first
        self.facebookAcc = resource.socialMedia?.facebook?.first
        self.youtubeAcc = resource.socialMedia?.youtubeChannel?.first
        
        self.latitude = resource.addresses?.first?.gps?.latitude
        self.longitude = resource.addresses?.first?.gps?.longitude
        
        // Create work hours
        
        if let sundayFrom = resource.bizHours?.sunday.from, let sundayTo = resource.bizHours?.sunday.to {
            self.sundayWorkHour = "Sunday From: \(sundayFrom) To \(sundayTo)"
        } else {
            self.sundayWorkHour = "No Available Data"
        }
        
        if let mondayFrom = resource.bizHours?.monday.from, let mondayTo = resource.bizHours?.monday.to {
            self.mondayWorkHour = "Monday From: \(mondayFrom) To \(mondayTo)"
        } else {
            self.mondayWorkHour = "No Available Data"
        }
        
        // Create address
        let address = "\(resource.addresses?.first?.address1 ?? "") \(resource.addresses?.first?.label ?? "") \(resource.addresses?.first?.city ?? "") \(resource.addresses?.first?.state ?? "") \(resource.addresses?.first?.country ?? "")"
        
        if address == "    " {
            self.address = "No Available Data"
        } else {
            self.address = address
        }
        
        // Create Descriptoion
        if let text = resource.description.html2AttStr {
            self.description = text
        } else {
            self.description = NSAttributedString(string: "No Available Data")
        }
    }
}
