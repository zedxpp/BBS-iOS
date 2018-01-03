//
//  PostListCell.swift
//  BBS-iOS
//
//  Created by peng on 2017/11/24.
//  Copyright © 2017年 swift520. All rights reserved.
//

import UIKit

class PostListCell: PPTableViewCell {
    
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var timeLabel: UILabel!
    @IBOutlet fileprivate weak var bgImageView: UIImageView!
    @IBOutlet fileprivate weak var adjustViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var userIconIV: UIImageView!
    @IBOutlet fileprivate weak var userNameLabel: UILabel!
    @IBOutlet fileprivate weak var collectionBtn: UIButton!
    @IBOutlet fileprivate weak var coverView: UIView!
    @IBOutlet weak var bgView: UIView!
    
    var postListModel: PostModel? {
        didSet {
            titleLabel.text = postListModel?.postTitle
            
            if let time = postListModel?.postCreateTime {
                timeLabel.text = Date.date(String(describing: time))
            } else {
                timeLabel.text = "加载中..."
            }
            
            userNameLabel.text = postListModel?.user?.userNickName

            userIconIV.kf.setImage(with: URL(string: postListModel?.user?.userIcon ?? String()))
            
            if postListModel?.postContentPics?.isEmpty != true {
                if let pics = postListModel?.postContentPics {
                    let strArr = pics.components(separatedBy: ",")
                    if !strArr.isEmpty && strArr.first?.isEmpty == false {
                        bgImageView.kf.setImage(with: URL(string: strArr.first!))
                        bgImageView.isHidden = false
                        coverView.isHidden = false
                        adjustViewHeightConstraint.constant = 140
                    }
                }
            } else {
                bgImageView.isHidden = true
                coverView.isHidden = true
                adjustViewHeightConstraint.constant = 0
            }
            
//            printLog(bgImageViewTopConstraint.constant)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
