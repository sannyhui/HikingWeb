//
//  HikingManager.swift
//  HikingWebPage
//
//  Created by Sanny Hui on 29/7/2022.
//

import Foundation

class HikingManager {
    var hikings: [Hiking] = []
    
    func fetch() {
        if let url = Bundle.main.url(forResource: "hiking", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                hikings = try JSONDecoder().decode([Hiking].self, from: data)
            } catch {
                print("\(error)")
            }
        }
    }
}
