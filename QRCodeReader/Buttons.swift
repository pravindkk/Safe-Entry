//
//  Buttons.swift
//  QRCodeReader
//
//  Created by Kunasilan on 19/10/20.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import Foundation
import UIKit

class RoundedButton: UIButton {

    required init() {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}


