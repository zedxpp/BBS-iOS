//
//  ForumListViewController.swift
//  BBS-iOS
//
//  Created by peng on 2017/11/23.
//  Copyright © 2017年 swift520. All rights reserved.
//

import UIKit
import SwiftyJSON

fileprivate let ForumListCellID = "ForumListCellID"

class ForumListViewController: PPViewController {
    
    // MARK: - property
    
    fileprivate var forumArray: [ForumModel] = []
    
    // MARK: - func
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(view).offset(20)
        }
        
        loadForumList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - networking
    
    fileprivate func loadForumList() {
        
        //        startAnimating()
        
        forumProvider.request(.forumList) { (result) in
            
            //            self.stopAnimating()
            
            switch result {
            case let .success(moyaResponse):
                do {
                    let json = try JSON(data: moyaResponse.data)
                    
                    //                    printLog(json)
                    
                    
                    for j in json["data"].arrayValue {
                        
                        guard let str = j.rawString() else {
                            continue
                        }
                        
                        guard let model = ForumModel(JSONString: str) else {
                            continue
                        }
                        
                        self.forumArray.append(model)
                    }
                    
                    if !self.forumArray.isEmpty {
                        
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

    
    // MARK: - lazy
    
    fileprivate lazy var tableView: PPTableView = {
        let tableView = PPTableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        //        tableView.backgroundColor = UIColor.red
        
        tableView.register(UINib(nibName: Tool.removeNameSpace(ForumListCell.self), bundle: Bundle.main), forCellReuseIdentifier: ForumListCellID)
        return tableView
    }()
    

}

extension ForumListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forumArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForumListCellID) as! ForumListCell
        cell.model = forumArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postVC = PostListViewController()
        let model = forumArray[indexPath.row]
        postVC.forumId = model.id
        postVC.title = model.forumName
        navigationController?.pushViewController(postVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
}
