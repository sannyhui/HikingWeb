//
//  Item2Cell.swift
//  HikingWebPage
//
//  Created by Sanny Hui on 29/7/2022.
//

import UIKit

class Item2Cell: UICollectionViewCell {
    
    static let cellID = "cell2ID"
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView()
        imageView.frame = contentView.bounds
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
