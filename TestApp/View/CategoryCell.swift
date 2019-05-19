//
//  CategoryCell.swift
//  TestApp
//
//  Created by Keyhan on 5/18/19.
//  Copyright © 2019 Keyhan. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var categoryImgView: UIImageView!

    // MARK: - Awake From Nib
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Configure Cell
    public func configureCell(with category: Category) {
        if category.title == "Restaurants" {
            categoryImgView.image = #imageLiteral(resourceName: "undraw_eating_together_tjhx")
        } else if category.title == "Vacation Spots" {
            categoryImgView.image = #imageLiteral(resourceName: "undraw_Camping_2g8w")
        }
    }
}
