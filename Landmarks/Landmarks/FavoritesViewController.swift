//
//  FavoritesViewController.swift
//  Landmarks
//
//  Created by Michael Mackiney on 2/9/20.
//  Copyright © 2020 Michael Mackiney. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate {

    @IBOutlet var favoritesTable: UITableView!
    weak var delegate: PlacesFavoritesDelegate?
    var annotations: [Place] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTable.delegate = self

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.annotations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel!.text = self.annotations[indexPath.row].title
        print(self.annotations[indexPath.row].title)

        return cell
    }

}
