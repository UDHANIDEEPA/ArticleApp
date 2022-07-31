//
//  ArticleTableViewCell.swift
//  ArticleApp
//
//  Created by Vanshika on 29/07/2022.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    
    var articleVM : ArticleViewModel? {
        didSet {
            DispatchQueue.main.async {
                self.configureCell()
            }
        }
    }
 
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell() {
        self.titleLabel.text = articleVM?.title
        self.authorLabel.text = articleVM?.author
        self.dateLabel.text = articleVM?.publishDate
        self.articleImageView.downloadImage(url: articleVM?.thumbnailImageUrl ?? "")
    }
}
