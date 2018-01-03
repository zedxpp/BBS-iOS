//
//  PostDetailsCell.swift
//  BBS-iOS
//
//  Created by peng on 2017/12/6.
//  Copyright © 2017年 swift520. All rights reserved.
//

import UIKit

class PostDetailsCell: PPTableViewCell {
    
    @IBOutlet fileprivate weak var iconImageView: UIImageView!
    @IBOutlet fileprivate weak var userNameLabel: UILabel!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var contentLabel: UILabel!
    @IBOutlet fileprivate weak var readCountLabel: UILabel!
    @IBOutlet fileprivate weak var forumLabel: UILabel! //
    @IBOutlet fileprivate weak var createTimeLabel: UILabel!
    @IBOutlet fileprivate weak var collectionBtn: UIButton!
    
    var postDetails: PostModel? {
        didSet {
            iconImageView.kf.setImage(with: URL(string: postDetails?.user?.userIcon ?? String()))
            
            userNameLabel.text = postDetails?.user?.userNickName
            
            titleLabel.text = postDetails?.postTitle
            
//            contentLabel.attributedText = postDetails?.postContent?.attributedString()
            
//            printLog(contentLabel.frame.width)
            
            
            contentLabel.attributedText = postDetails?.postContent?.replacingOccurrences(of: "<img src=\"", with: "<img width=\"\(Tool.screenW - 15 * 2)\" src=\"").attributedString()
//            contentLabel.backgroundColor = UIColor.randomColor
            
            readCountLabel.text = String(describing: postDetails?.postReadCount ?? 0)
            
            if let time = postDetails?.postCreateTime {
                createTimeLabel.text = Date.date(String(describing: time))
            } else {
                createTimeLabel.text = "加载中..."
            }
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
