//
//  Item2CellDetails.swift
//  HikingWebPage
//
//  Created by Sanny Hui on 29/7/2022.
//

import UIKit

class Item2CellDetails: UIViewController {
    
    static let segueID = "item2Segue"
    var selectedItem: Gallery!
    var imageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView = UIImageView()
        imageView.frame = view.bounds
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        showImage()
    }

    func showImage() {
        imageView.image = UIImage(named: selectedItem.image)
    }
}
