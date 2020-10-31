//
//  CanGetImageViewController.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/25.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit
#warning("使用protocol")
class CanGetImageViewController:UIViewController{
    func getImage(type:ImageURLType,imageURL:String,completion:@escaping(UIImage?)->Void){
            var urlStr:String
            switch type {
            case .gill:
                urlStr = "http://35.185.131.56:8002/" + imageURL
                print(imageURL)
            case .other:
                urlStr = imageURL
            }
            let url = URL(string: urlStr)!
   //         DispatchQueue.main.sync {
                do
            {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                completion(image)
            }catch
            {
                print("image is error")
            }
//            }
        }
    }
    enum ImageURLType{
        case gill,other
    }

