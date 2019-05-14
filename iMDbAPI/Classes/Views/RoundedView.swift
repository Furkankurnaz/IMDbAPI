//
//  RoundedView.swift
//  iMDbAPI
//
//  Created by Furkan Kurnaz on 14.05.2019.
//  Copyright © 2019 Furkan Kurnaz. All rights reserved.
//

import UIKit

class RoundedView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    func configureView() {
        self.layer.cornerRadius = 10
    }

}
