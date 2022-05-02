//
//  Unimage+Extension.swift
//  flickrFeed
//
//  Created by Pu Yue - PU YUE on 2022/05/03.
//

import Foundation
import UIKit

extension UIImage {
    public convenience init(url: URL) {
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data)!
            return
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        self.init()
    }
}
