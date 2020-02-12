//
//  DataManager.swift
//  Landmarks
//
//  Created by Michael Mackiney on 2/9/20.
//  Copyright © 2020 Michael Mackiney. All rights reserved.
//

import Foundation

public class DataManager {
  
    // MARK: - Singleton Stuff
    public static let sharedInstance = DataManager()
  
    //This prevents others from using the default '()' initializer
    fileprivate init() {}

    // Your code (these are just example functions, implement what you need)
    func saveFavorites(places: [Place]) {
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: places, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "favorites")
        }
    }
    func deleteFavorites() {
        UserDefaults.standard.removeObject(forKey: "favoritesarray")
    }
}
