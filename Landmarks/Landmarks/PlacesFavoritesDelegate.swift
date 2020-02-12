//
//  PlacesFavoritesDelegate.swift
//  Landmarks
//
//  Created by Michael Mackiney on 2/9/20.
//  Copyright © 2020 Michael Mackiney. All rights reserved.
//

import Foundation

protocol PlacesFavoritesDelegate: class {
  func favoritePlace(name: String) -> Void
}
