//
//  CanGetImageViewController.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/9/25.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit
#warning("使用protocol")
class CanGetImageViewController: UIViewController {
    func getImage(type: ImageURLType, imageURL: String, completion: @escaping (UIImage?) -> Void) {
        var urlStr: String
        switch type {
        case .gill:
            urlStr = "https://storage.googleapis.com/gcs.gill.gq/" + imageURL
        // print("https://storage.googleapis.com/gcs.gill.gq" + imageURL)
        case .other:
            urlStr = imageURL
        }
        let url = URL(string: urlStr)!
        //         DispatchQueue.main.sync {
        do {
            let data = try Data(contentsOf: url)
            let image = UIImage(data: data)
            completion(image)
        } catch {
            print("image is error")
            completion(UIImage(named: "single"))
        }
//            }
    }
}

enum ImageURLType {
    case gill, other
}
