//
//  Protocols.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/10/5.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import UIKit

protocol ResponseActionDelegate {
    func shouldRefreshToken()
    
    func shouldRetry()
}

protocol Storyboarded {
    static func instantiate() -> Self
}

protocol LoadingViewDelegate {
    
    
    var loadingView : UIView { get }
    
    func loadingActivityView()
    
    func stopLoadActivityView()
}
