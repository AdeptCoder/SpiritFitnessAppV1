//
//  UserDetailsViewController.swift
//  MyUserRegistration
//
//  Created by Niraj Thanki on 4/2/17.
//  Copyright © 2017 Niraj Thanki. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Firebase

class UserDetailsViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate,GADBannerViewDelegate {
      @IBOutlet weak var nextbtn: UIButton!
    @IBOutlet weak var PhotoLibrary: UIButton!
    @IBOutlet weak var adBannerview: GADBannerView!
    @IBOutlet weak var Camera: UIButton!
    @IBOutlet weak var ImageViewOrg: UIImageView!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var emailidlabel: UILabel!
    @IBOutlet weak var agelabel: UILabel!
    @IBOutlet weak var sexlabel: UILabel!
    @IBOutlet weak var weightlabel: UILabel!
    
    @IBAction func LogOutAction(_ sender: Any) {
        try! FIRAuth.auth()!.signOut()
        SingletonClass.shared.isLoggedin = false
            let loginPageController = (
                storyboard?.instantiateViewController(
                    withIdentifier: "LoginContoller")
                )!
            loginPageController.modalTransitionStyle = .crossDissolve
            present(loginPageController, animated: true, completion: nil)
        
            namelabel.text = ""
                SingletonClass.shared.username = ""
            emailidlabel.text = ""
                SingletonClass.shared.useremail = ""
            agelabel.text = ""
                SingletonClass.shared.userage = ""
            sexlabel.text = ""
                SingletonClass.shared.usersex = ""
            weightlabel.text = ""
                SingletonClass.shared.userweight = ""
        SingletonClass.shared.userid = ""
        SingletonClass.shared.workoutData = [:]
        SingletonClass.shared.walkdata = [:]
        SingletonClass.shared.userDict = [:]
        SingletonClass.shared.today = ""
        SingletonClass.shared.selectedDate = ""
        SingletonClass.shared.datevalue = ""
        SingletonClass.shared.workoutsetNumber = 0
        SingletonClass.shared.duration = 0.0
        SingletonClass.shared.noOfSteps = 0
        SingletonClass.shared.workoutSource = ""
        SingletonClass.shared.stepsSource = ""
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        adBannerview.delegate = self
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
    
    @IBAction func ChangeProfilePicAction(_ sender: Any) {
        let changeProfilePicMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let CameraAction = UIAlertAction(title: "Camera", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.CameraActionfn()
            
        })
        let photoLib = UIAlertAction(title: "Photo Library", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.PhotoLibActionfn()
            
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.CancelActionfn()
            
        })

        changeProfilePicMenu.addAction(CameraAction)
        changeProfilePicMenu.addAction(photoLib)
        changeProfilePicMenu.addAction(cancel)
        self.present(changeProfilePicMenu, animated: true, completion: nil)
    }
    
    func CancelActionfn(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func CameraActionfn(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerControllerSourceType.camera // for taking photo with camera
        picker.allowsEditing = false
        present(picker, animated:true) {
        }
    }
    
    func PhotoLibActionfn(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary  // for selecting picture from photoLibrary
        picker.allowsEditing = false
        self.present(picker, animated:true) {
        }
 
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let picker = info[UIImagePickerControllerOriginalImage] as? UIImage {
            ImageViewOrg.image = picker
        } else {
            // Error Message
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool){
        if(!SingletonClass.shared.isLoggedin){
            let loginPageController = (
                storyboard?.instantiateViewController(
                    withIdentifier: "LoginContoller")
                )!
            loginPageController.modalTransitionStyle = .crossDissolve
            present(loginPageController, animated: true, completion: nil)
        }
        else{
            namelabel.text = SingletonClass.shared.username
            emailidlabel.text = SingletonClass.shared.useremail
            agelabel.text =  SingletonClass.shared.userage
            sexlabel.text = SingletonClass.shared.usersex
            weightlabel.text = SingletonClass.shared.userweight
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
