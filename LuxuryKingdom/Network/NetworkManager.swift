//
//  NetworkManager.swift
//  LuxuryKingdom
//
//  Created by MacProAtif on 04/04/18.
//  Copyright © 2018 Aimran. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager: NSObject {
    
    class var instance: NetworkManager {
        struct Singleton{
          static let object = NetworkManager()
        }
        return Singleton.object
    }
    
    func downloadUserData(){
        
        let params:Parameters = [
            "id":"a"
        ]
        let head:HTTPHeaders = [
            "ContentType":"application/json",
            "Accept": "application/json"
        ]
        Alamofire.request("https://jsonplaceholder.typicode.com/posts/1", method: .get, parameters: params, headers: head).responseJSON { (response) in
            print(response.value as! NSDictionary)
        }
    }

}
