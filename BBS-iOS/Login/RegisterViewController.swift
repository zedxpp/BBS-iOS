//
//  RegisterViewController.swift
//  BBS-iOS
//
//  Created by pengpeng on 2017/12/24.
//  Copyright © 2017年 swift520. All rights reserved.
//

import UIKit
import SwiftyJSON

class RegisterViewController: PPViewController {
    
    @IBOutlet weak var nickNameTF: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func registerBtnClick(_ sender: UIButton) {
        
        guard let nickName = nickNameTF.text else {
            printLog("昵称不能是空")
            return
        }
        
        if nickName.count < 1 || nickName.count > 10 {
            printLog("昵称必须是1~10位")
            return
        }
        
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

//        print(base64)
        
        startAnimating()
        view.endEditing(true)
        loginProvider.request(LoginNetWorking.createUser(phone: phone, password: base64, nickname: nickName)) { (result) in
            
            self.stopAnimating()
            
            switch result {
            case let .success(moyaResponse):
                do {
                    let json = try JSON(data: moyaResponse.data)
//                    printLog(json)
                    
                    if json["code"].intValue == 200 {
                        printLog("注册成功")
                        
                        self.navigationController?.popViewController(animated: true)
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
    
    static func registerViewController() -> RegisterViewController? {
        let vc = UIStoryboard(name: Tool.removeNameSpace(RegisterViewController.self), bundle: nil).instantiateInitialViewController() as? RegisterViewController
        return vc
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        startAnimation()
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
//            self.
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        printLog("注册控制器释放")
    }

}
