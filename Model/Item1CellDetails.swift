//
//  Item1CellDetails.swift
//  HikingWebPage
//
//  Created by Sanny Hui on 31/7/2022.
//

import UIKit

class Item1CellDetails: UIViewController {
    
    static let segueID = "item1Segue"
    var selectedItem: Hiking!
    var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let width = view.bounds.width
        let height = view.bounds.height
        textView = UITextView()
        textView.frame = CGRect(x: 10, y: 90, width: width - 20, height: height - 180)
        textView.backgroundColor = UIColor.darkGray
        textView.isEditable = false
        textView.textColor = UIColor.white
        textView.font = UIFont(name: "Helvetica-Light", size: 20)
        textView.text = selectedItem.text
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
    }
}
