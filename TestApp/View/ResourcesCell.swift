//
//  SelectedCatCell.swift
//  TestApp
//
//  Created by Keyhan on 5/18/19.
//  Copyright © 2019 Keyhan. All rights reserved.
//

import UIKit

class ResourcesCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var backgroundImgView: UIImageView!
    @IBOutlet weak var containerView: CustomView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!

    // MAARK: - Awake From Nib
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Prepare For Reuse
    override func prepareForReuse() {
        backgroundImgView.image = UIImage()
    }
    
    // MARK: - Configure Cell
    public func configureCell(resource: Resource) {
        // Create phots url and donwload it
        let url = resource.photo
        backgroundImgView.loadImage(fromURL: url)
        
        titleLbl.text = resource.title
        
        // Convert the HTML description to attributed text
        guard let attributedText = resource.description.html2AttStr else {
            return
        }
        // Set text
        descriptionLbl.attributedText = attributedText
    }

}
