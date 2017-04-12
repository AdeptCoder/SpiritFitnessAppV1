//
//  Pedometer.swift
//  SpiritFitnessApp_Team4_SwiftProject
//
//  Created by Sumirna Philips on 4/2/17.
//  Copyright © 2017 19483. All rights reserved.
//

import Foundation
import UIKit
import CoreMotion
import GoogleMobileAds
class WalkingMeter: UIViewController,GADBannerViewDelegate {
    
    @IBOutlet weak var adBannerview: GADBannerView!
    @IBOutlet weak var stepsLabel: UILabel!
var days:[String] = []
var stepsTaken:[Int] = []
let pedoMeter = CMPedometer()
    
override func viewDidLoad() {
    
    super.viewDidLoad()
    
    var cal = NSCalendar.current
    var comps = cal.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
    comps.hour = 0
    comps.minute = 0
    comps.second = 0
    let timeZone = NSTimeZone.system
    cal.timeZone = timeZone
    
    let midnightOfToday = cal.date(from: comps)!
    
    if(CMPedometer.isStepCountingAvailable()){
        
        self.pedoMeter.startUpdates(from: midnightOfToday) { (data: CMPedometerData?, error) -> Void in
            DispatchQueue.main.async(execute: { () -> Void in
                if(error == nil){
                   self.stepsLabel.text =  "TOTAL STEPS TODAY: \(data!.numberOfSteps)"
                    
                }
            })
        }
    }
    
    adBannerview.delegate = self
    //appDelegate.adBannerView.isHidden = true
    adBannerview.rootViewController = self
    adBannerview.adUnitID = "ca-app-pub-9339720089672206/8417837977"
    adBannerview.load(GADRequest())
    
    
    }
    
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        adBannerview.isHidden = false
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        adBannerview.isHidden = true
    }


override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
}
}
