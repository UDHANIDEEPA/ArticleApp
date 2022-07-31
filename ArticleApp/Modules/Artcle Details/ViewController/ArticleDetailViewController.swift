//
//  ArticleDetailViewController.swift
//  ArticleApp
//
//  Created by Vanshika on 31/07/2022.
//

import Foundation
import UIKit

class ArticleDetailsViewController: UIViewController {
    @IBOutlet weak var articleImageView:  UIImageView!
    //@IBOutlet weak var publishedDateLabel: UILabel!
    @IBOutlet weak var articleAuthorLabel: UILabel!
    @IBOutlet weak var articleDescriptionTextView: UITextView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    
    var selectedArticle:  ArticleViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let article = selectedArticle {
            articleTitleLabel.text = article.title
            articleAuthorLabel.text = article.author
            articleDescriptionTextView.text = article.description
            self.articleImageView.downloadImage(url: article.descriptionImageUrl)
        }
    }
    
    
}
