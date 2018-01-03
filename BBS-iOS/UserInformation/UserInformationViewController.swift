//
//  UserInformationViewController.swift
//  BBS-iOS
//
//  Created by pengpeng on 2017/12/6.
//  Copyright © 2017年 swift520. All rights reserved.
//

import UIKit
import SwiftyJSON

fileprivate let PostListCellID = "PostListCellID"

class UserInformationViewController: PPViewController {
    
    // MARK: - property
    
    fileprivate var userModel: UserModel?
    
    // MARK: - lazy
    
    fileprivate lazy var infoBgView: UIView = {
        let ibgv = UIView()
        
        return ibgv
    }()
    
    fileprivate lazy var iconImageView: UIImageView = {
        let iiv = UIImageView()
        //        iiv.backgroundColor = UIColor.randomColor
        return iiv
    }()
    
    fileprivate lazy var nameLabel: UILabel = {
        let nl = UILabel()
        nl.text = "昵称"
        nl.font = UIFont.systemFont(ofSize: 15)
        return nl
    }()
    
    fileprivate lazy var joinTimeLabel: UILabel = {
        let jtl = UILabel()
        jtl.text = "加入时间"
        jtl.font = UIFont.systemFont(ofSize: 15)
        return jtl
    }()
    
    fileprivate lazy var tableView: PPTableView = {
        let tv = PPTableView(frame: CGRect.zero, style: .grouped)
        tv.delegate = self
        tv.dataSource = self
        
        
        
        tv.register(UINib(nibName: Tool.removeNameSpace(PostListCell.self), bundle: Bundle.main), forCellReuseIdentifier: PostListCellID)
        return tv
    }()
    
    // MARK: - func

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(infoBgView)
        infoBgView.addSubview(iconImageView)
        infoBgView.addSubview(nameLabel)
        infoBgView.addSubview(joinTimeLabel)
        view.addSubview(tableView)
        
        infoBgView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
        }

        iconImageView.snp.makeConstraints { (make) in
            make.left.top.equalTo(infoBgView).offset(15)
            make.width.height.equalTo(60)
            make.bottom.equalTo(infoBgView).offset(-15)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(12)
            make.right.equalTo(infoBgView).offset(-15)
            make.bottom.equalTo(iconImageView.snp.centerY).offset(-2)
        }

        joinTimeLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(nameLabel)
            make.top.equalTo(infoBgView.snp.centerY).offset(2)
        }
        
//        tableView.snp.makeConstraints { (make) in
//            make.left.right.bottom.equalToSuperview()
//            make.top.equalTo(infoBgView.snp.bottom)
//        }
        loadUserInfo()
    }
    
    // MARK: - networking
    
    fileprivate func loadUserInfo() {
        
        userProvider.request(.getUserInfo(postId: Int(User.userId)!)) { (result) in
            
            
            switch result {
            case let .success(moyaResponse):
                do {
                    let json = try JSON(data: moyaResponse.data)
                    
                    printLog(json)
                    
                    guard let str = json.dictionaryValue["data"]?.rawString() else {
                        return
                    }

                    guard let model = UserModel(JSONString: str) else {
                        return
                    }
                    
                    self.userModel = model
                    
                    if let icon = model.userIcon {
                        self.iconImageView.kf.setImage(with: URL(string: icon))
                    }
                    
                    if let name = model.userNickName {
                        self.nameLabel.text = name
                    }
                    
                    
                    if model.userCreateTime > 0 {
                        
                        self.joinTimeLabel.text = "加入时间: \(Date.date(String(model.userCreateTime)))"
                    }
                    
                    
                } catch {
                    print(error)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension UserInformationViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostListCellID) as! PostListCell
        return cell
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

