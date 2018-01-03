//
//  PostListViewController.swift
//  BBS-iOS
//
//  Created by peng on 2017/11/24.
//  Copyright © 2017年 swift520. All rights reserved.
//

import UIKit
import SwiftyJSON

fileprivate let PostListCellID = "PostListCellID"

class PostListViewController: PPViewController {
    
    // MARK: - property
    
    fileprivate var postArray: [PostModel] = []
    
    var forumId: Int = 0
    
    // MARK: - lazy
    
    fileprivate lazy var tableView: PPTableView = {
        let tv = PPTableView()
        tv.delegate = self
        tv.dataSource = self
        
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: 0, height: 15)
        tv.tableHeaderView = headerView
        tv.estimatedRowHeight = 300
        tv.rowHeight = UITableViewAutomaticDimension
        
        tv.register(UINib(nibName: Tool.removeNameSpace(PostListCell.self), bundle: Bundle.main), forCellReuseIdentifier: PostListCellID)
        return tv
    }()
    
    fileprivate lazy var addBtn: UIButton = {
        let btn = UIButton(type: .custom)
        //        btn.backgroundColor = UIColor.cyan
        
        //        btn.layer.cornerRadius = 20
        
        
        btn.setImage(UIImage(named: "addBtn"), for: .normal)
        
        btn.addTarget(self, action: #selector(self.addBtnClick), for: .touchUpInside)
        
        //        btn.frame.size = CGSize(width: 40, height: 40)
        
        return btn
    }()
    
    // MARK: - func
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if forumId > 0 {
            navigationController?.setNavigationBarHidden(false, animated: animated)
        } else {
            navigationController?.setNavigationBarHidden(true, animated: animated)
        }
        
    }
    
    @objc fileprivate func addBtnClick() {
        
        let vc = PostReleaseViewController()
        vc.forumId = self.forumId
        vc.callBack = {
            self.postArray.removeAll()
            self.loadPostList()
        }
        
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            
            if forumId == 0 {
                make.top.equalTo(view).offset(20)
            } else {
                make.top.equalTo(view)//.offset(20)
            }
        }
        
        
        
        //        view.addSubview(addBtn)
        //        addBtn.snp.makeConstraints { (make) in
        //            make.left.equalToSuperview().offset(30)
        //            make.bottom.equalToSuperview().offset(-76)
        //            make.size.equalTo(CGSize(width: 40, height: 40))
        //        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addBtn)
        
        loadPostList()
    }
    
    // MARK: - networking
    

    fileprivate func loadPostList() {
        
        //        startAnimating()
        
        postProvider.request(.postList(forumId: forumId)) { (result) in
            
            //            self.stopAnimating()
            
            switch result {
            case let .success(moyaResponse):
                do {
                    let json = try JSON(data: moyaResponse.data)
                    
                    for j in json["data"].arrayValue {
                        
                        guard let str = j.rawString() else {
                            continue
                        }
                        
                        guard let model = PostModel(JSONString: str) else {
                            continue
                        }
                        
                        self.postArray.append(model)
                    }
                    
                    if !self.postArray.isEmpty {
                        //                        print(self.postArray.count)
                        self.tableView.reloadData()
                    }
                } catch {
                    print(error)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}

extension PostListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostListCellID) as! PostListCell
        let tmp = postArray[indexPath.row]
        cell.postListModel = tmp
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postDetailsVC = PostDetailsViewController()
        let tmp = postArray[indexPath.row]
        postDetailsVC.postId = tmp.id
        navigationController?.pushViewController(postDetailsVC, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 84
//    }
}
