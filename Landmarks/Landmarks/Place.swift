//
//  Place.swift
//  Landmarks
//
//  Created by Michael Mackiney on 2/9/20.
//  Copyright © 2020 Michael Mackiney. All rights reserved.
//

import UIKit
import MapKit

class Place: MKPointAnnotation, NSCoding {

    var name: String?
    var longDescription: String?
    var favorite = false
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as? String
        longDescription = aDecoder.decodeObject(forKey: "longDescription") as? String
        favorite = (aDecoder.decodeObject(forKey: "favorite") as? Bool)!
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(longDescription, forKey: "longDescription")
        aCoder.encode(favorite, forKey: "favorite")
    }
    
}
