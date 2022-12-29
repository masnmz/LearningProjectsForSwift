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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
