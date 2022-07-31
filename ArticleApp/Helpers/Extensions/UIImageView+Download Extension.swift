//
//  UIImageView+Download Extension.swift
//  ArticleApp
//
//  Created by Vanshika on 29/07/2022.
//

import Foundation
import AlamofireImage
import UIKit

extension UIImageView
{
    func downloadFrom(link:String?, contentMode mode: UIView.ContentMode)
    {
        contentMode = mode
        if link == nil
        {
            self.image = UIImage(named: "default")
            return
        }
        if let url = NSURL(string: link!)
        {
            print("\nstart download: \(url.lastPathComponent!)")
            URLSession.shared.dataTask(with: url as URL, completionHandler: { (data, _, error) -> Void in
                guard let data = data, error == nil else {
                    print("\nerror on download \(String(describing: error))")
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    print("\ndownload completed \(url.lastPathComponent!)")
                    self?.image = UIImage(data: data)
                    self?.setNeedsLayout()
                    self?.layoutSubviews()
                }
            }).resume()
        }
        else
        {
            self.image = UIImage(named: "default")
        }
    }
}

extension UIImageView {
    
    func downloadImage(url: String){
        if let fileUrl = URL(string: url) {
    
            self.af_setImage(withURL: fileUrl, placeholderImage: UIImage(named: "default.png"))
        }
            
    }
    
}
