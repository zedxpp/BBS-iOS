//
//  LoginViewController.swift
//  BBS-iOS
//
//  Created by pengpeng on 2017/12/24.
//  Copyright © 2017年 swift520. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: PPViewController {

    var loginSuccess: (() -> ())?
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginBtnClick(_ sender: UIButton) {
        guard let phone = phoneTextField.text else {
            printLog("手机号不能是空")
            return
        }
        
        if phone.count != 11 || phone.hasPrefix("1") == false {
            printLog("不是手机号")
            return
        }
        
        guard let password = passwordTextField.text else {
            printLog("密码不能是空")
            return
        }
        
        if password.count < 6 || password.count > 10 {
            printLog("密码必须是6~10位")
            return
        }
        
        let data = (password).data(using: String.Encoding.utf8)
        let base64 = data!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        startAnimating()
        view.endEditing(true)
        loginProvider.request(.loginAccount(phone: phone, password: base64)) { (result) in
            
            self.stopAnimating()
            
            switch result {
            case let .success(moyaResponse):
                do {
                    let json = try JSON(data: moyaResponse.data)
                    printLog(json)
                    
                    if json["code"].intValue == 200 {
                        printLog("登录成功")
                        
                        let tmp = json["data"].dictionaryValue["id"]
                        
                        if let userID = tmp?.intValue {
                            
                            
                            
//                            printLog(userId)
                            UserDefaults.standard.set(true, forKey: Tool.isLogin)
                            UserDefaults.standard.set(String(userID), forKey: Tool.userId)
                            let bo = UserDefaults.standard.synchronize()
                            if self.loginSuccess != nil && bo {
                                self.loginSuccess!()
                            }
                        }
                        
                    } else {
                        printLog(json["codeMsg"])
                    }
                } catch {
                    print(error)
                }
            case let .failure(error):
                print(error)
            }
        }
        
    }
    
    @IBAction func registerBtnClick(_ sender: UIButton) {
        navigationController?.pushViewController(RegisterViewController.registerViewController()!, animated: true)
    }
    
    static func loginViewController() -> LoginViewController? {
        let vc = UIStoryboard(name: Tool.removeNameSpace(LoginViewController.self), bundle: nil).instantiateInitialViewController() as? LoginViewController
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        printLog("登录控制器释放")
    }
}
