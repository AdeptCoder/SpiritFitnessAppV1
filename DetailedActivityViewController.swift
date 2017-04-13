//
//  DetailedActivityViewController.swift
//  SpiritFitnessApp_Team4_SwiftProject
//
//  Created by Sumirna Philips on 4/4/17.
//  Copyright © 2017 19483. All rights reserved.
//

import UIKit
import GoogleMobileAds

class activityDetailsCustomTableViewCell: UITableViewCell{
    @IBOutlet weak var deviceSourceDetials: UILabel!
    @IBOutlet weak var durationDetails: UILabel!
    @IBOutlet weak var caloriesBurntDetails: UILabel!
    @IBOutlet weak var workOutSetsCount: UILabel!
}

class activityDetailsCustomForStepsTableViewCell: UITableViewCell{
    @IBOutlet weak var deviceSourceDetail: UILabel!
    @IBOutlet weak var noOfStepsDetails: UILabel!
    @IBOutlet weak var caloriesBurntByWalkDetail: UILabel!
    @IBOutlet weak var distanceWalkedDetails: UILabel!
}

class DetailedActivityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,GADBannerViewDelegate {
   @IBOutlet weak var dateTitleLabel: UILabel!
    
    
    
    
    @IBOutlet weak var adBannerview: GADBannerView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int{
            return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "firsttableCell", for: indexPath) as! activityDetailsCustomTableViewCell
            cell.workOutSetsCount?.text = "\(SingletonClass.shared.workoutsetNumber)"
            cell.caloriesBurntDetails?.text = "\(SingletonClass.shared.workoutsetNumber * 60)"
            cell.durationDetails?.text = "\(SingletonClass.shared.duration)"
            cell.deviceSourceDetials?.text = SingletonClass.shared.workoutSource
            return cell
        }
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "secondtableCell", for: indexPath) as! activityDetailsCustomForStepsTableViewCell
            let distance = Double(SingletonClass.shared.noOfSteps)/2000.00
            cell.noOfStepsDetails?.text = "\(SingletonClass.shared.noOfSteps)"
            cell.distanceWalkedDetails?.text = "\(distance)"
            cell.caloriesBurntByWalkDetail?.text = "\(distance * 75)"
            cell.deviceSourceDetail?.text = SingletonClass.shared.stepsSource
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        
    }
    
func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    let myLabel = UILabel(frame: CGRect(x: 20, y: 8, width: 320, height: 20))
    let systemDynamicFontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: UIFontTextStyle.headline)
    let size = systemDynamicFontDescriptor.pointSize
    let font = UIFont(name: "ArialHebrew-Bold", size:size)
    
     myLabel.font = font
    myLabel.textColor = UIColor.darkGray
   // myLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
    myLabel.text = self.tableView(tableView,titleForHeaderInSection:section)
    let headerView:UIView = UIView(frame: CGRect(x: 0, y: 8, width: 320, height: 30))

    headerView.addSubview(myLabel)
    return headerView;
    }
   
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return "Work Out"}
        else{
            return "Walking"
        }
    }

    @IBAction func dismissModalViewButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateTitleLabel.text = SingletonClass.shared.selectedDate
        
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
        // Do any additional setup after loading the view.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
