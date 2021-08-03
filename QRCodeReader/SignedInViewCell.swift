//
//  SignedInViewCell.swift
//  QRCodeReader
//
//  Created by Kunasilan on 19/10/20.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import UIKit


protocol SignedInCellDelegate {
    
    func didTapCheckOut(url: String, sender: UIButton)
}

class SignedInViewCell: UITableViewCell {
    
    @IBOutlet var signedInTitle: UILabel!
    
    var signedInItem: signedIn!
    var delegate: SignedInCellDelegate?
    
    func setSignInTitle(signedIn: signedIn) {
        signedInItem = signedIn
//        videoImageView.image = video.image
        signedInTitle.text = signedIn.title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func watchNowTapped(_ sender: UIButton) {
        delegate?.didTapCheckOut(url: signedInItem.url, sender: sender)
    }
    
}
