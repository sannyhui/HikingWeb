//
//  Item3Details.swift
//  HikingWebPage
//
//  Created by Sanny Hui on 30/7/2022.
//

import UIKit

class Item3Details: UIViewController {
    
    static let segueID = "item3Segue"
    var selectedItem: Map!
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
        imageView.image = UIImage(named: selectedItem.image!)
    }

}
