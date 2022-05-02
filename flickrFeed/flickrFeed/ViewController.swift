//
//  ViewController.swift
//  flickrFeed
//
//  Created by Pu Yue - PU YUE on 2022/05/02.
//

import UIKit

class ViewController: UIViewController {
    
    var items: [Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Api.shared.getData { [self] items, error in
            if let items = items {
                self.items = items
            }
        }
    }


}

