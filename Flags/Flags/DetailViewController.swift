//
//  DetailViewController.swift
//  Flags
//
//  Created by Mehmet Alp Sönmez on 27.12.2022.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var selectedFlagImage : String?
    var selectedName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = selectedName
        navigationController?.navigationBar.prefersLargeTitles = false
        if let imageToShow = selectedFlagImage{
            imageView.image = UIImage(named: imageToShow)
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
    }
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    @objc func shareTapped(){
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
                print("No image found")
                return
            }

            let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
            vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
            present(vc, animated: true)
    }

}
