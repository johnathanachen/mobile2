//
//  PostsTableViewCell.swift
//  Product_Hunt_API
//
//  Created by Johnathan Chen on 11/4/17.
//  Copyright © 2017 JCSwifty. All rights reserved.
//

import UIKit
import WebKit

class PostsTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var postImage: WKWebView!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postSubtitleLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UIButton!
    
//    // MARK: - Actions
//    @IBAction func upVoteButton(_ sender: UIButton) {
//    }
//    @IBAction func commentButton(_ sender: UIButton) {
//    }
//
    var post: Product? {
        didSet {
            postTitleLabel.text = post?.name
            print(postTitleLabel.text, "this is ")
            postSubtitleLabel.text = post?.tagline
            voteCountLabel.titleLabel?.text = "\(post?.votes ?? 0)"
            let request = URLRequest(url: (post?.imageurl)!)
            postImage.load(request)
        }
    }
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
