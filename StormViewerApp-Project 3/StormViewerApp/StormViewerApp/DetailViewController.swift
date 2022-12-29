//
//  DetailViewController.swift
//  StormViewerApp
//
//  Created by Mehmet Alp Sönmez on 18.12.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView : UIImageView!
    var selectedImage : String?
    var selectedPictureNumber = 0
    var totalNumberOfPics = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(selectedPictureNumber) of \(totalNumberOfPics)"
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

        if let imageToLoad = selectedImage{
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnTap = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.hidesBarsOnTap = false
    }
   @objc func shareTapped(){
       guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else{
           print("No Image found")
           return
       }
       let vc = UIActivityViewController(activityItems: [image,selectedImage as Any], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
