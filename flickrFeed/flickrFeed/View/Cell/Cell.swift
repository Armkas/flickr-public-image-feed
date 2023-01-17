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
    
    func configure(_ item: Item, callback: @escaping(() -> Void)) {
        DispatchQueue.global().async{//先转到后台线程,下载好了在转回main线程
            do{
                let imageData = try Data(contentsOf: item.media.m)
                let image = UIImage(data: imageData)//得到图片实例后才转main线程
                
                DispatchQueue.main.async {
                    self.imageView1.image = image
                    self.imageView1.sizeToFit()
                    callback()
                }
            } catch{
                print(error)
            }
        }
    }
}
