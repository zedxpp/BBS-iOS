//
//  PostDetailsCommentCell.swift
//  BBS-iOS
//
//  Created by peng on 2017/12/6.
//  Copyright © 2017年 swift520. All rights reserved.
//

import UIKit

class PostDetailsCommentCell: PPTableViewCell {
    
    @IBOutlet fileprivate weak var quoteConstraint: NSLayoutConstraint!
    
    @IBOutlet fileprivate weak var floorLabel: UILabel!
    @IBOutlet fileprivate weak var timeLabel: UILabel!
    @IBOutlet fileprivate weak var userIconIV: UIImageView!
    @IBOutlet fileprivate weak var userNameLabel: UILabel!
    @IBOutlet fileprivate weak var commentQuoteLabel: UILabel!
    @IBOutlet fileprivate weak var commentLabel: UILabel!
    
    var comment: CommentModel? {
        didSet {
            
            if let floor = comment?.commentFloor {
                floorLabel.text = "第\(floor)楼"
            }
            
            if let time = comment?.commentCreateTime {
                timeLabel.text = Date.date(String(describing: time))
            }
            
            userNameLabel.text = comment?.user?.userNickName
            
            userIconIV.kf.setImage(with: URL(string: comment?.user?.userIcon ?? String()))
            
            commentLabel.text = comment?.commentContent
            
            if let quote = comment?.quoteComment {
                
                commentQuoteLabel.text = "@\(quote.user?.userNickName ?? "加载异常") 发表于 \(Date.date(String(describing: quote.commentCreateTime))) \n \(quote.commentContent ?? "加载异常")"
                
            } else {
                hiddenQuote()
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        commentLabel.font = UIFont.systemFont(ofSize: 13)
        commentQuoteLabel.font = commentLabel.font
    }

    func hiddenQuote() {
        commentQuoteLabel.text = ""
        quoteConstraint.constant = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
