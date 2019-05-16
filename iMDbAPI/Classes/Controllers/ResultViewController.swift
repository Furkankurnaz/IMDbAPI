//
//  ResultViewController.swift
//  iMDbAPI
//
//  Created by Furkan Kurnaz on 16.05.2019.
//  Copyright © 2019 Furkan Kurnaz. All rights reserved.
//

import UIKit
import Kingfisher

class ResultViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var results: SearchModel!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    // MARK: - Helper Functions
    
    func configureView() {
        tableView.rowHeight = 100
    }

}

// MARK: - UITableViewDataSource

extension ResultViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.search.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = results.search[indexPath.row]
        let imageURL = item.poster
        let title = item.title
        let type = item.type
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TABLEVIEWCELLS.RESULT.rawValue, for: indexPath) as! ResultTableViewCell
        
        cell.setView(title: title, type: type, imageURL: imageURL)
        
        return cell
    }
}
