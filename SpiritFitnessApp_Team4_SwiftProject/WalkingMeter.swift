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
  
    override func viewWillAppear(_ animated: Bool) {
        
        var cal = NSCalendar.current
        var comps = cal.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
        comps.hour = 0
        comps.minute = 0
        comps.second = 0
        let timeZone = NSTimeZone.system
        cal.timeZone = timeZone
        var steps = NSNumber(integerLiteral: 0)
        let midnightOfToday = cal.date(from: comps)!
        
        if(CMPedometer.isStepCountingAvailable()){
            
            self.pedoMeter.startUpdates(from: midnightOfToday) { (data: CMPedometerData?, error) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    if(error == nil){
                         steps = data!.numberOfSteps
                        if(Int(steps) > 0){
                            let todayWalkData:[String:Any] = ["noofsteps":steps, "source":UIDevice.current.name]
                        walkmeterRef.child(SingletonClass.shared.userid).child(SingletonClass.shared.today).updateChildValues(todayWalkData)
                        }
                        self.stepsLabel.text =  "TOTAL STEPS TODAY: \(steps)"
                        
                    }
                })
            }
        }
        
       /*steps = NSNumber(integerLiteral: 2000)
        
        let todayWalkData:[String:Any] = ["noofsteps":steps, "source":UIDevice.current.name]
        walkmeterRef.child(SingletonClass.shared.userid).child(SingletonClass.shared.today).updateChildValues(todayWalkData)*/
        
    }
    
override func viewDidLoad() {
    super.viewDidLoad()
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
