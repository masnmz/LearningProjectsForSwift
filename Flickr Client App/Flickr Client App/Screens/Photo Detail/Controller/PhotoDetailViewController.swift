//
//  PhotoDetailViewController.swift
//  Flickr Client App
//
//  Created by Mehmet Alp Sönmez on 28.11.2022.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    var photo: Photo?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photo Detail"
        imageView.backgroundColor = .gray
        ownerImageView.layer.cornerRadius = 24.0
        ownerImageView.backgroundColor = .darkGray
        ownerNameLabel.text = "Owner Name"
        descriptionLabel.text = " Description Label Description Label Description Label Description Label Description Label "
        
        ownerNameLabel.text = photo?.ownername
        
        NetworkManager.shared.fetchImage(with: photo?.buddyIconurl) { data in
            self.ownerImageView.image = UIImage(data: data)
        }
        NetworkManager.shared.fetchImage(with: photo?.urlZ) { data in
            self.imageView.image = UIImage(data: data)
        }
        //        cell.photoImageView.backgroundColor = .gray
        title = photo?.title
        descriptionLabel.text = photo?.description?.content
        
    }

}
