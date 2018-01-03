//
//  ViewController.swift
//  测试moya
//
//  Created by peng on 2017/12/7.
//  Copyright © 2017年 peng. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        provider.request(.postList) { (result) in
            switch result {
            case let .success(moyaResponse):
                
                let json: JSON
                
                do {
                    json = try JSON(data: moyaResponse.data)
                    
                    for j in json["data"].arrayValue {
                        //                    print(j.rawString())
                        if let str = j.rawString() {
                            let moel = Model(JSONString: str)
//                            print(moel?.postTitle)
                            print(moel)
                        }
                    }
                } catch {
                    
                }
                

            
                
                
                

                
            // do something in your app
            case let .failure(error):
                print(error)
                // TODO: handle the error == best. comment. ever.
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    provider.request(.zen) { result in
//    switch result {
//    case let .success(moyaResponse):
//    let data = moyaResponse.data // Data, your JSON response is probably in here!
//    let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
//    
//    // do something in your app
//    case let .failure(error):
//    // TODO: handle the error == best. comment. ever.
//    }
//    }
    
//    provider.request(.zen) { result in
//    // do something with `result`
//    }

//    let provider = MoyaProvider<MyService>()
//    provider.request(.createUser(firstName: "James", lastName: "Potter")) { result in
//    // do something with the result (read on for more details)
//    }
//    
//    // The full request will result to the following:
//    // POST https://api.myservice.com/users
//    // Request body:
//    // {
//    //   "first_name": "James",
//    //   "last_name": "Potter"
//    // }
//    
//    provider.request(.updateUser(id: 123, firstName: "Harry", lastName: "Potter")) { result in
//    // do something with the result (read on for more details)
//    }
//    
//    // The full request will result to the following:
//    // POST https://api.myservice.com/users/123?first_name=Harry&last_name=Potter
}

