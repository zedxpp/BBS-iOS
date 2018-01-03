//
//  PostReleaseToolView.swift
//  BBS-iOS
//
//  Created by peng on 2017/11/27.
//  Copyright © 2017年 swift520. All rights reserved.
//

import UIKit

@objc protocol PostReleaseToolViewDelegate {
//    @objc optional func postReleaseToolView(_ postReleaseToolView: PostReleaseToolView)
    
    @objc optional func postReleaseToolView(_ postReleaseToolView: PostReleaseToolView, attributesDidChange attributes: [String: Any])
    
    @objc optional func postReleaseToolViewPictureDidClick(_ postReleaseToolView: PostReleaseToolView)
    
    @objc optional func postReleaseToolViewBackBtnDidClick(_ postReleaseToolView: PostReleaseToolView)
    
    @objc optional func postReleaseToolViewLinkBtnDidClick(_ postReleaseToolView: PostReleaseToolView)
}

let PostReleaseToolViewFontDefaultSize: CGFloat = 15.0
let PostReleaseToolViewFontDefaultColor: UIColor = UIColor.black

class PostReleaseToolView: UIView {

    var delegate: PostReleaseToolViewDelegate?
    
    var attributes: [String: Any] {
        var dict: [String: Any] = [NSAttributedStringKey.font.rawValue: isBold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)]
        if !fontColor.isEmpty {
            dict[NSAttributedStringKey.foregroundColor.rawValue] = UIColor(fontColor)
        }
        
        return dict
    }
    
    let nativeColorArr = [UIColor.black, UIColor.darkGray, UIColor.lightGray, UIColor.gray, UIColor.red, UIColor.green, UIColor.blue, UIColor.cyan, UIColor.magenta, UIColor.orange, UIColor.purple, UIColor.brown]
    
    var fontSize = PostReleaseToolViewFontDefaultSize
    var fontColor = ""
    var isBold = false
    
    var selectBtn: UIButton?
    
    enum PostReleaseToolViewBtnType: String {
        case picture// = "图片"
        case fontSize// = "字体大小"
        case bold// = "加粗"
        case fontColor// = "字体颜色"
        case link // http链接
//        case back
        
        case none
        
        static var allValues: [PostReleaseToolViewBtnType] {
            return [.picture, .fontSize, .bold, .fontColor, .link]
        }
    }
    
//    enum PostReleaseToolViewFontSize: Int {
//        case <#case#>
//    }
    
    var currentBtnType: PostReleaseToolViewBtnType = .none {
        didSet {
            if currentBtnType == .none {
                collectionView.isHidden = true
            } else {
                collectionView.isHidden = false
            }
        }
    }
    
    let fontSizeArr = [Int(PostReleaseToolViewFontDefaultSize), 19, 26, 35, 46, 58]
    lazy var fontColorArr: [String] = {
        var arr: [String] = []
        for c in nativeColorArr {
            arr.append(c.hexString())
        }
        return arr
    }()
    
    let scrollView = UIScrollView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.lightGray
        self.frame = CGRect(x: 0, y: 0, width: Tool.screenW, height: 42)
        
        let backBtn = UIButton(type: .custom)
//        backBtn.backgroundColor = UIColor.orange
        
        backBtn.setImage(UIImage(named: "btn_close"), for: .normal)
//        backBtn.sizeToFit()
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        addSubview(backBtn)
        
        backBtn.snp.makeConstraints { (make) in
            make.right.top.bottom.equalToSuperview()
            make.width.equalTo(60)
        }
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(backBtn.snp.left)
        }
        
        
        
        var totalW: CGFloat = 0
        for (_, value) in PostReleaseToolViewBtnType.allValues.enumerated() {
            let btn = UIButton(type: .custom)
            btn.titleLabel?.textAlignment = .center
//            btn.setTitle(value.rawValue, for: .normal)
        
            switch value {
            case .picture:
                
                btn.setImage(UIImage(named: "toolView_picture"), for: .normal)
            case .fontSize:
                btn.setTitle(String(Int(PostReleaseToolViewFontDefaultSize)), for: .normal)
            case .bold:
                let att = NSAttributedString(string: "B", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15), NSAttributedStringKey.foregroundColor: UIColor.white])
                
                btn.setAttributedTitle(att, for: .normal)
                
                let att2 = NSAttributedString(string: "B", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.white])
                btn.setAttributedTitle(att2, for: .selected)
                
            case .fontColor:
                btn.backgroundColor = PostReleaseToolViewFontDefaultColor
                
            case .link:
                btn.setImage(UIImage(named: "toolView_link"), for: .normal)
            default:
                printLog("未识别")
            }
            
            
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btn.sizeToFit()
            btn.frame.size.width += 10
            btn.frame.size.height = self.frame.size.height
            
            btn.frame.origin = CGPoint(x: totalW, y: 0)
            
            totalW += btn.frame.size.width
            
            scrollView.addSubview(btn)
            
            btn.addTarget(self, action: #selector(self.toolViewBtnClick(btn:)), for: .touchUpInside)
        }
        
        scrollView.contentSize = CGSize(width: totalW, height: 0)//self.frame.size.height
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        collectionView.isHidden = true
    }
    
    @objc fileprivate func toolViewBtnClick(btn: UIButton) {
        
        guard let view = scrollView.subviews.index(of: btn) else {
            return
        }
        
        let type = PostReleaseToolViewBtnType.allValues[view]
        currentBtnType = type
        
        selectBtn = btn
        
        switch type {
        case .bold:
            isBold = !isBold
            btn.isSelected = isBold
            collectionView.isHidden = true
            delegate?.postReleaseToolView?(self, attributesDidChange: attributes)
        case .picture:
            collectionView.isHidden = true
            delegate?.postReleaseToolViewPictureDidClick?(self)
        case .link:
            collectionView.isHidden = true
            delegate?.postReleaseToolViewLinkBtnDidClick?(self)
        default:
            collectionView.reloadData()
        }
        
    }
    
    @objc fileprivate func backBtnClick() {
        delegate?.postReleaseToolViewBackBtnDidClick?(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.frame.size.height, height: self.frame.size.height)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = self.backgroundColor
//        cv.backgroundColor = UIColor.gray
        cv.isHidden = true
        cv.bounces = false
        cv.delegate = self
        cv.dataSource = self
        
        cv.register(PostReleaseToolViewItem.self, forCellWithReuseIdentifier: PostReleaseToolViewItemID)
        
        return cv
    }()
}

extension PostReleaseToolView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch currentBtnType {
        case .fontSize:
            return fontSizeArr.count
        case .fontColor:
            return fontColorArr.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostReleaseToolViewItemID, for: indexPath) as! PostReleaseToolViewItem
        
        switch currentBtnType {
        case .fontSize:
            cell.fontSize = fontSizeArr[indexPath.item]
        case .fontColor:
            cell.fontColorStr = fontColorArr[indexPath.item]
        default:
            cell.fontSize = 0
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PostReleaseToolViewItem
        switch currentBtnType {
        case .fontSize:
            fontSize = CGFloat(cell.fontSize)
//            print(cell.fontSize)
        case .fontColor:
            fontColor = cell.fontColorStr
//            print(cell.fontColorStr)
        default:
            print()
        }
        
        if let btn = selectBtn {
            switch currentBtnType {
            case .fontSize:
                
                
                btn.setTitle(String(Int(fontSize)), for: .normal)
                
            case .fontColor:
    
                btn.backgroundColor = UIColor(fontColor)
                
            default:
                print()
            }
        }
        
        collectionView.isHidden = true
        delegate?.postReleaseToolView?(self, attributesDidChange: attributes)
        
        
        
//        printLog(delegate?.postReleaseToolView(self))
    }
}

fileprivate let PostReleaseToolViewItemID = "PostReleaseToolViewItemID"

fileprivate class PostReleaseToolViewItem: UICollectionViewCell {
    
    var fontSize: Int = 0 {
        didSet {
//            printLog(fontSize)
            label.text = String(describing: fontSize)
        }
    }
    
    var fontColorStr: String = "" {
        didSet {
            label.text = ""
            label.backgroundColor = UIColor(fontColorStr)
        }
    }
    
//    let label = UILabel()
    let label: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: PostReleaseToolViewFontDefaultSize)
        l.textColor = UIColor.white
        l.textAlignment = .center
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        
//        backgroundColor = UIColor.cyan
    
        addSubview(label)
//        label.font = UIFont.systemFont(ofSize: <#T##CGFloat#>)
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


