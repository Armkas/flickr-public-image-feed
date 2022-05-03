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
    
    var item: Item?
    
    @IBAction func clickBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openUrl(_ sender: Any) {
        if let url: URL = item?.link {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func share(_ sender: Any) {
        guard let url: URL = item?.media.m else { return }
        let shareImage = UIImage(url: url)
        let activityItems = [shareImage] as [Any]
        let toVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        present(toVC, animated: true, completion: nil)
    }
    
    func setup(_ item: Item) {
        self.item = item
        detailImageVIew.image = UIImage(url: item.media.m)
        titleLabel.text = item.title
        authorLabel.text = item.author
    }
}
