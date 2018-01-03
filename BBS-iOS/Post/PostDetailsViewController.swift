//
//  PostDetailsViewController.swift
//  BBS-iOS
//
//  Created by peng on 2017/12/6.
//  Copyright © 2017年 swift520. All rights reserved.
//

import UIKit
import SwiftyJSON

fileprivate let PostDetailsCellID = "PostDetailsCellID"
fileprivate let PostDetailsCommentCellID = "PostDetailsCommentCellID"


class PostDetailsViewController: PPViewController {
    
    
    // MARK: - property
    
    var postId: Int?
    
    fileprivate var postDetails: PostModel?
    fileprivate var commentArr = [CommentModel]()
    
    fileprivate var textView: UITextView?
    
    fileprivate var commentIndex = 0
    
    fileprivate var commentViewDictM = [Int: UIView]()
    
    // MARK: - func
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc func openKeyboard(_ notification: Notification) {
        //        printLog(notification.userInfo)
        
        guard let userInfo = notification.userInfo else {
            return
        }
        
        guard let keyboardFrame = userInfo[AnyHashable(UIKeyboardFrameEndUserInfoKey)] as? CGRect else {
            return
        }
        
        guard let duration = userInfo[AnyHashable(UIKeyboardAnimationDurationUserInfoKey)] as? TimeInterval else {
            return
        }
        
        guard let anima = userInfo[AnyHashable(UIKeyboardAnimationCurveUserInfoKey)] as? UInt else {
            return
        }
        
        let option: UIViewAnimationOptions = UIViewAnimationOptions(rawValue: anima)
        
        let h = keyboardFrame.origin.y - 64
        
        guard let v = commentViewDictM[commentIndex] else {
            return
        }
        
        guard let tv = v.subviews.first as? UITextView else {
            return
        }
        
        guard let btn = v.subviews[1] as? UIButton else {
            return
        }
        
        v.isHidden = false
        
        UIView.animate(withDuration: duration, delay: 0, options: option, animations: {
            v.frame.origin.y = 0
            v.frame.size.height = h
            tv.frame.origin.y = h - tv.frame.height
            btn.frame.origin.y = h - btn.frame.height
            
        }, completion: { (bo) in
            tv.becomeFirstResponder()
        })
    }
    
    @objc func closeKeyboard(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo else {
            return
        }
        
        guard let duration = userInfo[AnyHashable(UIKeyboardAnimationDurationUserInfoKey)] as? TimeInterval else {
            return
        }
        
        guard let anima = userInfo[AnyHashable(UIKeyboardAnimationCurveUserInfoKey)] as? UInt else {
            return
        }
        
        let option: UIViewAnimationOptions = UIViewAnimationOptions(rawValue: anima)
        
        guard let v = commentViewDictM[commentIndex] else {
            return
        }
        
        guard let tv = v.subviews.first as? UITextView else {
            return
        }
        
        guard let btn = v.subviews[1] as? UIButton else {
            return
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: option, animations: {
            v.frame.origin.y = Tool.screenH
            v.frame.size.height = 50
            tv.frame.origin.y = 0
            btn.frame.origin.y = 0
            
        }, completion: { (bo) in
            v.isHidden = true
            //            if tv.isFirstResponder {
            //                tv.resignFirstResponder()
            //            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(openKeyboard(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(closeKeyboard(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 40, 0))
        }
        
        view.addSubview(openCommentTextField)
        openCommentTextField.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(tableView.snp.bottom)
        }
        
        
        //        view.backgroundColor = UIColor.randomColor
        //        printLog(postId)
        loadPostDetails()
    }
    
    @objc fileprivate func openCommentTextFieldClick() {
        
        commentIndex = 0
        
        var tmpV = commentViewDictM[commentIndex]
        
        if tmpV == nil {
            let v = UIView()
            tmpV = v
            //            v.backgroundColor = UIColor.randomColor
            
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.coverViewHidden(_:)))
            v.addGestureRecognizer(tap)
            
            view.addSubview(v)
            
            let tv = UITextView()
            tv.layer.borderWidth = 1
            tv.layer.borderColor = UIColor.black.cgColor
            
            //            tv.text = "我是输入框"
            v.addSubview(tv)
            
            let btn = UIButton(type: .custom)
            btn.backgroundColor = UIColor.cyan
            btn.setTitle("发布", for: .normal)
            btn.addTarget(self, action: #selector(self.releaseComment), for: .touchUpInside)
            v.addSubview(btn)
            btn.sizeToFit()
            
            v.frame = CGRect(x: 0, y: Tool.screenH, width: view.frame.width, height: 50)
            tv.frame = CGRect(x: 0, y: 0, width: view.frame.width - btn.frame.width, height: 50)
            btn.frame.origin.x = tv.frame.width
            btn.frame.origin.y = 0
            btn.frame.size.height = tv.frame.height
            
            
            commentViewDictM[commentIndex] = v
            
        }
    }
    
    @objc fileprivate func coverViewHidden(_ tap: UIGestureRecognizer) {
        
        guard let tv = tap.view?.subviews.first as? UITextView else {
            return
        }
        
        tv.resignFirstResponder()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - networking
    
    
    @objc fileprivate func releaseComment() {
        //        printLog("啦啦")
        //        return
        loadCreateComment()
    }
    
    fileprivate func loadPostDetails() {
        
        //        startAnimating()
        
        
        //        let id = String(describing: postId)
        //        printLog(id)
        
        guard let id = postId else {
            return
        }
        
        postProvider.request(.postDetails(postId: id)) { (result) in
            //            self.stopAnimating()
            
            switch result {
            case let .success(moyaResponse):
                
                do {
                    let json = try JSON(data: moyaResponse.data)
                    
                    guard let str = json["data"].rawString() else {
                        return
                    }
                    
                    guard let model = PostModel(JSONString: str) else {
                        return
                    }
                    
                    self.postDetails = model
                    //                    self.tableView.reloadData()
                    
                    //                    self.tableView.reloadSections(IndexSet(integer: 0), with: UITableViewRowAnimation.none)
                    
                    self.loadCommentList()
                } catch {
                    print(error)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
    fileprivate func loadCommentList(_ isComment: Bool = false) {
        guard let id = postId else {
            return
        }
        
        commentProvider.request(.commentList(postId: id)) { (result) in
            switch result {
            case let .success(moyaResponse):
                do {
                    self.commentArr.removeAll()
                    
                    let json = try JSON(data: moyaResponse.data)
                    
                    //                    printLog(json)
                    
                    for j in json["data"].arrayValue {
                        
                        guard let str = j.rawString() else {
                            continue
                        }
                        
                        guard let model = CommentModel(JSONString: str) else {
                            continue
                        }
                        self.commentArr.append(model)
                        
                    }
                    
                    self.tableView.reloadData()
                    
                    if isComment {
                        self.tableView.scrollToRow(at: IndexPath(row: self.commentArr.count - 1, section: 1), at: UITableViewScrollPosition.bottom, animated: true)
                    }
                    
                    if self.tableView.isHidden == true {
                        self.tableView.isHidden = false
                    }
                    
                } catch {
                    print(error)
                }
            case let .failure(error):
                print(error)
            }
        }
        
    }
    
    fileprivate func loadCreateComment() {
        
        guard let id = postId else {
            return
        }
        
        guard let v = commentViewDictM[commentIndex] else {
            return
        }
        
        guard let tv = v.subviews.first as? UITextView else {
            return
        }
        
        if tv.text.isEmpty {
            printLog("内容不能是空")
            return
        }
        
        
        
        commentProvider.request(.createComment(content: tv.text, userId: 1, postId: id, quoteId: nil)) { (result) in
            
            
            
            
            switch result {
            case let .success(moyaResponse):
                
                
                let vi = self.commentViewDictM[self.commentIndex]
                
                if let viSub = vi?.subviews {
                    for v in viSub {
                        if v is UITextView {
                            let tv = v as! UITextView
                            tv.text = ""
                        }
                    }
                }
                
                do {
                    let json = try JSON(data: moyaResponse.data)
                    
                    printLog(json)
                    
                    //                    for j in json["data"].arrayValue {
                    //
                    //                        guard let str = j.rawString() else {
                    //                            continue
                    //                        }
                    //
                    //                        guard let model = CommentModel(JSONString: str) else {
                    //                            continue
                    //                        }
                    //                        self.commentArr.append(model)
                    //
                    //                    }
                    //
                    //                    self.tableView.reloadData()
                    
                    tv.resignFirstResponder()
                    
                    self.loadCommentList(true)
                    
                } catch {
                    print(error)
                }
            case let .failure(error):
                print(error)
            }
        }
        
    }
    
    
    
    // MARK: - lazy
    
    fileprivate lazy var openCommentTextField: UITextField = {
        //        let btn = UIButton(type: .custom)
        let btn = UITextField()
        //        btn.delegate = self
        btn.placeholder = "评论一下~"
        btn.borderStyle = UITextBorderStyle.line
        //        btn.setTitle("我要评论", for: .normal)
        //        btn.setTitleColor(UIColor.red, for: .normal)
        btn.addTarget(self, action: #selector(self.openCommentTextFieldClick), for: .editingDidBegin)
        return btn
    }()
    
    fileprivate lazy var tableView: PPTableView = {
        let table = PPTableView(frame: CGRect.zero, style: .grouped)
        table.delegate = self
        table.dataSource = self
        table.isHidden = true
        
        table.rowHeight = UITableViewAutomaticDimension
        table.estimatedRowHeight = 200
        
        table.register(UINib(nibName: Tool.removeNameSpace(PostDetailsCell.self), bundle: Bundle.main), forCellReuseIdentifier: PostDetailsCellID)
        table.register(UINib(nibName: Tool.removeNameSpace(PostDetailsCommentCell.self), bundle: Bundle.main), forCellReuseIdentifier: PostDetailsCommentCellID)
        
        return table
    }()
    
    
    

}

extension PostDetailsViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        openCommentTextFieldClick()
    }
}

extension PostDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return self.commentArr.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PostDetailsCellID) as! PostDetailsCell
            cell.postDetails = postDetails
//            cell.backgroundColor = UIColor.randomColor
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PostDetailsCommentCellID) as! PostDetailsCommentCell
            
            cell.comment = commentArr[indexPath.row]
            
//            if indexPath.row % 2 == 0 {
//                cell.hiddenQuote()
//            }
            
//            cell.backgroundColor = UIColor.randomColor
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}
