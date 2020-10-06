//
//  Protocols.swift
//  todolistURLPlus
//
//  Created by Ray Hsu on 2020/10/5.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import Foundation

protocol RefreshTokenDelegate {
    func shouldRefreshToken()
}

protocol Storyboarded {
    static func instantiate() -> Self
}

protocol LoadingViewDelegate {
    func startLoading()
    
    func stopLoading()
}
