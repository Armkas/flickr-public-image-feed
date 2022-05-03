//
//  DetailViewController.swift
//  flickrFeed
//
//  Created by Pu Yue - PU YUE on 2022/05/03.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailImageVIew: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBAction func clickBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func setup(_ item: Item) {
        detailImageVIew.image = UIImage(url: item.media.m)
        titleLabel.text = item.title
        authorLabel.text = item.author
    }
}
