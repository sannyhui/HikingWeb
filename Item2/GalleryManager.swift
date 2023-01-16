//
//  GalleryManager.swift
//  HikingWebPage
//
//  Created by Sanny Hui on 29/7/2022.
//

import Foundation

class GalleryManager {
    var galleries: [Gallery] = []
    
    func fetch(completion: ([Gallery]) -> Void) {
        var items: [Gallery] = []
        if let url = Bundle.main.url(forResource: "gallery", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                items = try JSONDecoder().decode([Gallery].self, from: data)
            } catch {
                print("\(error)")
            }
        }
        completion(items)
    }
}
