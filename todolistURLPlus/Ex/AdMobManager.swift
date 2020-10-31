//
//  AdMobManager.swift
//  todolistURLPlus
//
//  Created by Alvin Tseng on 2020/10/31.
//  Copyright © 2020 Alvin Tseng. All rights reserved.
//
import UIKit
import Foundation
import GoogleMobileAds
protocol AdAble {
    func setDelegate(vc:GADInterstitialDelegate)
    func presentAD(vc:UIViewController)
    func createAndLoadInterstitial() -> GADInterstitial
}
extension AdAble{
    func setDelegate(vc:GADInterstitialDelegate){
        AdManager.share.setDelegate(vc: vc)
    }
    func presentAD(vc:UIViewController){
        AdManager.share.presentAd(vc: vc)
    }
    func createAndLoadInterstitial() -> GADInterstitial{
        AdManager.share.createAndLoadInterstitial()
    }
}

class AdManager{
     
    static let share = AdManager()
    var interstitial: GADInterstitial!
    func presentAd(vc:UIViewController){
        if interstitial.isReady {
            
            interstitial.present(fromRootViewController: vc)
          } else {
            print("Ad wasn't ready")
          }
    }
    func setDelegate(vc:GADInterstitialDelegate){
        self.interstitial.delegate = vc
    }
    func createAndLoadInterstitial() -> GADInterstitial{
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
          interstitial.load(GADRequest())
          return interstitial
    }
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
      interstitial = createAndLoadInterstitial()
    }
}
