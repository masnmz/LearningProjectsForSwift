//
//  PhotoTableViewCell.swift
//  Flickr Client App
//
//  Created by Mehmet Alp Sönmez on 27.11.2022.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
   

    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ownerImageView.layer.cornerRadius = 24.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
