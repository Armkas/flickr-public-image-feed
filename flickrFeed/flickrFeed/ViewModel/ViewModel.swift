//
//  ViewModel.swift
//  flickrFeed
//
//  Created by Pu Yue - PU YUE on 2022/05/02.
//

import Foundation

class ViewModel {
    
    var items: [Item] = []
    
    func getData(_ completion: @escaping () -> Void) {
        Api.shared.getData { [self] items, error in
            if let items = items {
                self.items = items
                completion()
            }
        }
    }
}
