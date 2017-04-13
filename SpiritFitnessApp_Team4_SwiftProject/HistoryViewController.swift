//
//  HistoryViewController.swift
//  SpiritFitnessApp_Team4_SwiftProject
//
//  Created by Sumirna Philips on 4/2/17.
//  Copyright © 2017 19483. All rights reserved.
//

import UIKit
import Foundation
import GoogleMobileAds
import Firebase


class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,GADBannerViewDelegate {
    @IBOutlet weak var reportTableView: UITableView!
    var workoutitems = NSMutableArray()
    var workoutitemKeys = NSMutableArray()
    var walkitems = NSMutableArray()
    var walkitemKeys = NSMutableArray()
    var totalobject:Int = 0
    var workoutsource:String = ""
    @IBOutlet weak var adBannerview: GADBannerView!
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        return totalobject
}
func numberOfSections(in tableView: UITableView) -> Int{
   
        return 1
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        let keyval = self.workoutitemKeys[indexPath.row]
        let dictValues:NSDictionary = self.workoutitems[indexPath.row] as! NSDictionary
       let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        let sets = dictValues ["noofsets"]
    var steps = ""
    if(self.walkitemKeys.contains(keyval)){
       let walkDict:NSDictionary =  self.walkitems.object(at: self.walkitemKeys.index(of: keyval)) as! NSDictionary
        steps = walkDict ["noofsteps"] as! String
        cell.textLabel?.text = "   \(keyval) | \(sets!) workouts, \(steps) steps"
        
    }
    else{
        cell.textLabel?.text = "   \(keyval) | \(sets!) workouts"
    }
    
         return cell
    
}
  
func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath){
    let detailedViewController = (
        storyboard?.instantiateViewController(
            withIdentifier: "DetailedActivityModal")
        )!
    
    
    let keyval = self.workoutitemKeys[indexPath.row]
    var walkDict:NSDictionary = [:]
    if(self.walkitemKeys.contains(keyval)){
         walkDict =  self.walkitems.object(at: self.walkitemKeys.index(of: keyval)) as! NSDictionary
    }
    

    let dictValues:NSDictionary = self.workoutitems[indexPath.row] as! NSDictionary
    detailedViewController.modalTransitionStyle = .crossDissolve
    SingletonClass.shared.datevalue = self.workoutitemKeys[indexPath.row] as! String
    
    var sets = 0
     var duration = 0.0
     var source = ""
    if(dictValues.count != 0){
     sets = dictValues["noofsets"] as! Int
      duration = dictValues["duration"] as! Double
         source = dictValues["source"] as! String
    }
    SingletonClass.shared.selectedDate = keyval as! String
     SingletonClass.shared.workoutsetNumber = sets
     SingletonClass.shared.duration = duration
     SingletonClass.shared.workoutSource = source
    
    if(walkDict.count != 0){
    SingletonClass.shared.noOfSteps = walkDict ["noofsteps"] as! Int
     SingletonClass.shared.stepsSource = walkDict ["source"] as! String
    }
    
    present(detailedViewController, animated: true, completion: nil)
}
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        adBannerview.delegate = self
        //appDelegate.adBannerView.isHidden = true
        adBannerview.rootViewController = self
        adBannerview.adUnitID = "ca-app-pub-9339720089672206/8417837977"
        adBannerview.load(GADRequest())
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       // print("MODEL:::\(UIDevice.current.)")
        FIRDatabase.database().reference().child("walkmeter").child(SingletonClass.shared.userid).observeSingleEvent(of: .value, with: { (snapshot1) in
            
            let walkmeteruserDictionary = snapshot1.value as? [String:Any]!
            if(walkmeteruserDictionary != nil){
            SingletonClass.shared.walkdata = walkmeteruserDictionary!
            self.createlocalwalkdata()
                print("WALKING VALUE---->\(walkmeteruserDictionary)")}
        })
            
        FIRDatabase.database().reference().child("workoutData").child(SingletonClass.shared.userid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let workoutuserDictionary = snapshot.value as? [String:Any]!
            if(workoutuserDictionary != nil){
            SingletonClass.shared.workoutData = workoutuserDictionary!
            self.totalobject = (workoutuserDictionary?.count)!
           self.createlocalworkoutdata()
            self.reportTableView.reloadData()
            }
                   })
        
    }
    func createlocalwalkdata(){
        for (key, value) in SingletonClass.shared.walkdata{
            for(key1,value1) in value as! NSDictionary{
                self.walkitems.add(value1)
            }
            self.walkitemKeys.add(key)
        }
        
    }
    func createlocalworkoutdata(){
        for (key, value) in SingletonClass.shared.workoutData{
            var duration:Double = 0.0
            for(key1,value1) in value as! NSDictionary {
                 for(key2,value2) in value1 as! NSDictionary {
                    if(key2 as! String == "duration"){
                        let localduration = value2 as! Double
                    duration = duration + localduration
                    }
                    else{
                        workoutsource = "\(value2)"
                    }
            }
        }
            self.workoutitemKeys.add(key)
            self.workoutitems.add(["noofsets":(value as! NSDictionary).count,"duration":duration, "source":workoutsource] as NSDictionary);
           
    }
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        adBannerview.isHidden = false
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        adBannerview.isHidden = true
    }

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}


}
