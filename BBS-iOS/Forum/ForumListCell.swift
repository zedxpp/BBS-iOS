//
//  ForumListCell.swift
//  BBS-iOS
//
//  Created by pengpeng on 2017/11/23.
//  Copyright © 2017年 swift520. All rights reserved.
//

import UIKit

class ForumListCell: PPTableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    
    var model: ForumModel? {
        didSet {
            if let icon = model?.forumIcon {
                iconImageView.kf.setImage(with: URL(string: icon))
            }
            
            if let name = model?.forumName {
                nameLabel.text = name
            }
            
            if let des = model?.forumDes {
                desLabel.text = des
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
