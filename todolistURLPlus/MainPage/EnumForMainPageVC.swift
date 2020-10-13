//
//  EnumForMainPageVC.swift
//  todolistURLPlus
//
//  Created by Jimmy on 2020/10/13.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//

import Foundation
enum CollectionViewCellIdentifier: String
{
    case singleCell, mutipleCell
    var identifier: String
    {
        switch self
        {
        case .singleCell: return "singleCell"
        case .mutipleCell: return "mutipleCell"
        }
    }
}

enum WhichCollectionView
{
    case single
    case mutiple
}

enum WorkStatus
{
    case personal, mutiple
}
