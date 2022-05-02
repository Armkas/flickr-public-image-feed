//
//  Cell.swift
//  flickrFeed
//
//  Created by Pu Yue - PU YUE on 2022/05/03.
//

import Foundation
import UIKit

class Cell: UITableViewCell {
    
    @IBOutlet weak var imageView1: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(_ item: Item) {
        self.imageView1.image = UIImage(url: item.media.m)
    }
}
