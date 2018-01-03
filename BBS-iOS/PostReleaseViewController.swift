//
//  PostReleaseViewController.swift
//  BBS-iOS
//
//  Created by peng on 2017/11/24.
//  Copyright © 2017年 swift520. All rights reserved.
//

import UIKit
import Alamofire.Swift


class PostReleaseViewController: PPViewController {
    
    // MARK: - property
    
    
    var textViewAttributes: [String: Any]?
    
    let tmpPath = "PostImageTempDir".insertCachesPath()
    
    let imgMaxW = Tool.screenW - 10.0 - 6 * 2
    
    var forumId: Int = 0
    
    var callBack: (() -> ())?
    
    // MARK: - func
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
        
        editTextView.snp.updateConstraints { (make) in
            make.bottom.equalTo(view).offset(-keyboardFrame.size.height)
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: option, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
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
        
        editTextView.snp.updateConstraints { (make) in
            make.bottom.equalTo(view).offset(0)
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: option, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(openKeyboard(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(closeKeyboard(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        dirPrepare()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", target: self, action: #selector(self.releasePost))
        
        view.addSubview(titleTextFiled)
        titleTextFiled.snp.makeConstraints { (make) in
            make.top.equalTo(view)//.offset(20)
            make.left.equalTo(view).offset(6)
            make.right.equalTo(view).offset(-6)
            make.height.equalTo(45)
        }
        
        view.addSubview(editTextView)
        
        editTextView.snp.makeConstraints { (make) in
            make.top.equalTo(titleTextFiled.snp.bottom)
            make.left.right.equalTo(titleTextFiled)
            make.bottom.equalTo(view).offset(0)
        }
        
        titleTextFiled.addSubview(separateView)
        
        separateView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        
        //        let btn = UIButton(type: .custom)
        //        btn.backgroundColor = UIColor.randomColor
        //        btn.setTitle("生成", for: .normal)
        //        btn.addTarget(self, action: #selector(textClick), for: .touchUpInside)
        //        view.addSubview(btn)
        //
        //        btn.snp.makeConstraints { (make) in
        //            make.top.right.equalTo(editTextView)
        //        }
        //
        //        let btn2 = UIButton(type: .custom)
        //        btn2.backgroundColor = UIColor.randomColor
        //        btn2.setTitle("解析", for: .normal)
        //        btn2.addTarget(self, action: #selector(textClick2), for: .touchUpInside)
        //        view.addSubview(btn2)
        //
        //        btn2.snp.makeConstraints { (make) in
        //            make.top.equalTo(btn)
        //            make.right.equalTo(btn.snp.left)
        //        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.editTextView.becomeFirstResponder()
        }
    }
    
    @objc func textClick() {
        printLog(editTextView.attributedText.html())
    }
    
    @objc func textClick2() {
        var text = """
        <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
        <html>
        <head>
        <meta name="viewport" content="width=device-width,initial-scale=1"/>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta http-equiv="Content-Style-Type" content="text/css">
        <title></title>
        <meta name="Generator" content="Cocoa HTML Writer">
        <style type="text/css">
        p.p1 {margin: 0.0px 0.0px 0.0px 0.0px; font: 12.0px Helvetica}
        span.s1 {font-family: 'Helvetica'; font-weight: normal; font-style: normal; font-size: 12.00pt}
        </style>
        </head>
        <body>
        <p>111</p>
        <img src="http://cxp.im/images/20170225213251/14880211240769.jpg" alt="">
        <p>111</p>

        <img src="http://cxp.im/images/20170225213251/14880213549019.jpg" alt="">
        <p>111</p>
        <p>111</p>
        <img src="http://cxp.im/images/20170225213251/14880262928954.jpg" alt="">
        <p class="p1"><span class="s1"><a href="http://baidu.com">http://baidu.com 牛逼</a></span></p>
        </body>
        </html>
        """
        
        text = text.replacingOccurrences(of: "<img src=\"", with: "<img width=\"\(imgMaxW)\" src=\"")
        
        editTextView.attributedText = text.attributedString()
    }
    
    
    
    func replaceImgUrl(urls: [String]) {
        var htmlStr = editTextView.attributedText.html()
        //        printLog(htmlStr)
        
        var urlsStr = ""
        
        if !urls.isEmpty {
            htmlStr = htmlStr.replacingOccurrences(of: "file:///", with: String())
            
            for (index, value) in urls.enumerated() {
                
                if index == 0 {
                    
                    htmlStr = htmlStr.replacingOccurrences(of: "Attachment.png", with: value)
                } else {
                    htmlStr = htmlStr.replacingOccurrences(of: "Attachment_\(index).png", with: value)
                }
            }
            //            printLog("=================")
            printLog(htmlStr)
            
            for url in urls {
                urlsStr = urlsStr + url + ","
            }
            
            urlsStr.removeLast()
        }
        createPost(title: titleTextFiled.text!, content: htmlStr, pics: urlsStr)
    }
    
    fileprivate func dirPrepare() {
        let fm = FileManager.default
        
        func creatDir() {
            do {
                try fm.createDirectory(atPath: tmpPath, withIntermediateDirectories: false, attributes: nil)
            } catch {
                printLog(error)
            }
        }
        
        if fm.fileExists(atPath: tmpPath) {
            //            printLog("文件夹已存在")
            
            do {
                try fm.removeItem(atPath: tmpPath)
                creatDir()
            } catch {
                printLog(error)
            }
            
        } else {
            printLog("文件夹不存在")
            creatDir()
        }
    }
    
    
    
    @objc func releasePost() {
        
        if titleTextFiled.text?.isEmpty == true {
            printLog("标题不能为空")
            return
        }
        
        //
        //        printLog(editTextView.text)
        //        printLog(editTextView.attributedText)
        //        printLog(editTextView.attributedText.length)
        
        if editTextView.attributedText.length == 0 {
            printLog("内容不能为空")
            return
        }
        //
        
        //        return
        
        var picArr = [String]()
        var imageUrls = [URL]()
        editTextView.attributedText.enumerateAttribute(NSAttributedStringKey.attachment, in: NSMakeRange(0, editTextView.attributedText.length), options: NSAttributedString.EnumerationOptions.longestEffectiveRangeNotRequired, using: { (att, range, bo) in
            //            printLog(att)
            //            printLog(range)
            //            printLog(bo)
            if let attm = att as? PPTextAttachment {
                
                if let url = attm.imageURL, attm.image != nil {
                    //                    if let _ = attm.image {
                    picArr.append(url.lastPathComponent)
                    imageUrls.append(url)
                    //                    }
                }
                //                printLog(attm.imageURL?.lastPathComponent)
            }
        })
        
        if imageUrls.isEmpty {
            createPost(title: titleTextFiled.text!, content: editTextView.attributedText.html())
        } else {
            uploadAllImage(urls: imageUrls)
        }
        
        //        printLog(picArr)
        
    }

    
    func defaultAttributes() -> [String: Any] {
        return [NSAttributedStringKey.font.rawValue: UIFont.systemFont(ofSize: PostReleaseToolViewFontDefaultSize), NSAttributedStringKey.foregroundColor.rawValue: PostReleaseToolViewFontDefaultColor]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    // MARK: - networking
    
    func uploadAllImage(urls: [URL]) {
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for url in urls {
                let fileName = url.lastPathComponent
                
                let name = fileName.replacingOccurrences(of: "." + url.pathExtension, with: String())
                
                multipartFormData.append(url, withName: name, fileName: fileName, mimeType: "multipart/form-data")
            }
            
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: "\(httpAdress)uploadImages", method: .post, headers: nil) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                
                upload.uploadProgress { progress in // main queue by default
                    print("当前进度: \(progress.fractionCompleted)")
                }
                
                upload.responseJSON(completionHandler: { (response) in
                    
                    printLog(response.result.value)
                    
                    if let value = response.result.value as? [String: Any] {
                        
                        if let imageUrls = value["data"] as? [String] {
                            
                            self.replaceImgUrl(urls: imageUrls)
                            
                            //                            printLog(imageUrls)
                            
                        } else {
                            printLog(value)
                        }
                        
                        
                        
                        let dict = value as! Dictionary<String, Any>;
                        var error = response.result.error as NSError?
                        if let err = dict["error"] {
                            if (err as AnyObject).isKind(of: NSNull.self) {
                                // 成功
                                //                                printLog("成功")
                            } else {
                                // 失败
                                //                                printLog("失败",err)
                                error = NSError.init(domain: "strava", code: 0, userInfo: [NSLocalizedDescriptionKey:err])
                            }
                        }
                    } else {
                        
                    }
                })
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func createPost(title: String, content: String, pics: String = "") {
        
        var params: [String: Any] = ["title": title, "content": content, "userId": User.userId, "forumId": forumId]
        
        if !pics.isEmpty {
            params["pics"] = pics
        }
        Alamofire.request("\(httpAdress)creatPost", method: .post, parameters: params).responseJSON { (response) in
            //            printLog(response)
            if let res = response.result.value as? [String: Any] {
                printLog(res["codeMsg"])
                
                let code = res["code"] as? Int
                
                if code == 200 && self.callBack != nil {
                    
                    self.callBack!()
                    
                    self.navigationController?.popViewController(animated: true)
                }
                
            }
        }
    }
    
    
    // MARK: - lazy
    
    lazy var separateView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.lightGray
        return v
    }()
    
    lazy var toolView: PostReleaseToolView = {
        let tool = PostReleaseToolView()
        tool.delegate = self
        return tool
    }()
    
    lazy var titleTextFiled: UITextField = {
        let text = UITextField()
        //        text.backgroundColor = UIColor.randomColor
        text.placeholder = "请输入标题"
        text.font = UIFont.boldSystemFont(ofSize: 16)
        text.inputAccessoryView = toolView
        
        return text
    }()
    
    lazy var editTextView: UITextView = {
        let textV = UITextView()
        textV.delegate = self
        
        
        textV.inputAccessoryView = toolView
        
        
        textV.typingAttributes = defaultAttributes()
        return textV
    }()
    

}


extension PostReleaseViewController: PostReleaseToolViewDelegate {
    
    func postReleaseToolView(_ postReleaseToolView: PostReleaseToolView, attributesDidChange attributes: [String : Any]) {
        printLog(attributes)
        
        editTextView.typingAttributes = attributes
        textViewAttributes = attributes
        
    }
    
    func postReleaseToolViewPictureDidClick(_ postReleaseToolView: PostReleaseToolView) {
        let ipc = UIImagePickerController()
        //        ipc.sourceType = .camera
        ipc.navigationBar.isTranslucent = false;
        ipc.delegate = self
        present(ipc, animated: true, completion: nil)
    }
    
    func postReleaseToolViewBackBtnDidClick(_ postReleaseToolView: PostReleaseToolView) {
        if editTextView.isFirstResponder {
            editTextView.resignFirstResponder()
        }
    }
    
    func postReleaseToolViewLinkBtnDidClick(_ postReleaseToolView: PostReleaseToolView) {
        
        let ac = UIAlertController(title: "提示", message: "输入需要添加的http链接", preferredStyle: UIAlertControllerStyle.alert)
        let cancel = UIAlertAction(title: "cancel", style: UIAlertActionStyle.destructive, handler: nil)
        let confirm = UIAlertAction(title: "confirm", style: UIAlertActionStyle.default) { (confirm) in
            
            if let textField = ac.textFields?.first {
                let attM = NSMutableAttributedString(attributedString: self.editTextView.attributedText)
                
                if textField.text == nil {
                    textField.text = "http://"
                }
                
                let link = NSAttributedString(string: textField.text!, attributes: [NSAttributedStringKey.link: URL(string: textField.text!)!, .font: UIFont.systemFont(ofSize: PostReleaseToolViewFontDefaultSize)])
                
                attM.insert(link, at: self.editTextView.selectedRange.location)
                
                self.editTextView.attributedText = attM
            }
        }
        ac.addTextField { (textField) in
            textField.text = "http://"
        }
        
        ac.addAction(cancel)
        ac.addAction(confirm)
        
        present(ac, animated: true, completion: nil)
        
    }
    
    
}


extension PostReleaseViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            
            let fm = FileManager.default
            let url = info["UIImagePickerControllerImageURL"] as! URL
//            let fileName = url.lastPathComponent
        
//            printLog(url.lastPathComponent) // xxx.jpg
//            printLog(url.path) // 全路径 除开file://
//            printLog(url.pathExtension) // 后缀名
//            printLog(url.pathComponents) // 把整个路径地址打散成数组
//            printLog(url.absoluteString) 全路径 包含file://
            
            
            do {
                let newImagePath = tmpPath + "/" + Date.timeStamp + "." + url.pathExtension
                
                try fm.copyItem(atPath: url.path, toPath: newImagePath)
                
                let attM = NSMutableAttributedString(attributedString: editTextView.attributedText)
                
                let textAtt = PPTextAttachment()
                textAtt.imageURL = URL(string: "file://" + newImagePath)
                
                // 需要解包
                let oImg = UIImage(contentsOfFile: newImagePath)!
                    
                textAtt.image = oImg
                
                var rect = CGRect()
                var scale: CGFloat = 0.0
                if oImg.size.width > imgMaxW {
                    
                    scale = imgMaxW / oImg.size.width
                    rect = CGRect(x: 0, y: 0, width: imgMaxW, height: oImg.size.height * scale)
                } else {
                    rect = CGRect(origin: CGPoint.zero, size: oImg.size)
                }
                
                textAtt.bounds = rect
                
                let imgAtt = NSAttributedString(attachment: textAtt)
                
                
                
                attM.insert(imgAtt, at: editTextView.selectedRange.location)
                
                editTextView.attributedText = attM
                
//                printLog(editTextView.attributedText)
                
                
            } catch {
                printLog(error)
            }
            

        } else {
            printLog("无权限")
        }
        
        
        
        picker.dismiss(animated: true) {
            self.editTextView.becomeFirstResponder()
        }
    }
}

extension PostReleaseViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
//        printLog(textView.typingAttributes)
        
        if let att = textViewAttributes { // 有自定义待输入文本样式

            editTextView.typingAttributes = att
            
        } else {
                editTextView.typingAttributes = defaultAttributes()

        }
    }
 
}


//        var label = UILabel()
//        let start = 14
//        for i in start..<100 {
//            if i % 2 == 0 && i != start {
//                continue
//            }
//
//            let l = UILabel()
//            l.backgroundColor = UIColor.randomColor
//            l.text = String(i)
//            l.font = UIFont.systemFont(ofSize: CGFloat(i))
//            view.addSubview(l)
//
//            l.snp.makeConstraints({ (make) in
//                if i == start {
//                    make.top.equalToSuperview()
//                } else {
//                    make.top.equalTo(label.snp.bottom)
//                }
//                make.left.right.equalToSuperview()
//            })
//            label = l
//        }
