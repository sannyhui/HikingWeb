//
//  Hiking.swift
//  HikingWebPage
//
//  Created by Sanny Hui on 29/7/2022.
//

import Foundation

struct Hiking: Decodable, Hashable {
    var name: String
    var image: String
    var category: Category
    var text: String
}
