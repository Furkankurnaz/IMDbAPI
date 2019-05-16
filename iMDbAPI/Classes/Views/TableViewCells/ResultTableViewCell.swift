//
//  ResultTableViewCell.swift
//  iMDbAPI
//
//  Created by Furkan Kurnaz on 16.05.2019.
//  Copyright © 2019 Furkan Kurnaz. All rights reserved.
//

import UIKit
import Kingfisher

class ResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }
    
    func setView(title: String, type: String, imageURL: String) {
        titleLabel.text = title
        typeLabel.text = type
        mediaImageView.kf.setImage(with: URL(string: imageURL))
    }

}
