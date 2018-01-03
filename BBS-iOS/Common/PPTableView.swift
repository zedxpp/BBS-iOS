//
//  PPTableView.swift
//  BBS-iOS
//
//  Created by pengpeng on 2017/11/23.
//  Copyright © 2017年 swift520. All rights reserved.
//

import UIKit

class PPTableView: UITableView {

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        separatorStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
