//
//  SingletonClass.swift
//  SpiritFitnessApp_Team4_SwiftProject
//
//  Created by Sumirna Philips on 4/4/17.
//  Copyright © 2017 19483. All rights reserved.
//

import Foundation
import GoogleMobileAds

class SingletonClass{
    
    static let shared = SingletonClass()
    var isLoggedin:Bool
     var userid:String
    var username:String
    var userage:String
    var useremail:String
    var usersex:String
    var userweight:String
    var workoutData : [String:Any]
    var walkdata: [String:Any]
    var userDict :[String:Any]
    var today:String
    var selectedDate:String
    var datevalue:String
    var workoutsetNumber:Int
    var duration:Double
    var noOfSteps:Int
    var workoutSource:String
    var stepsSource:String
    
    
    private init(){
        workoutData = [:]
        walkdata = [:]
        userDict = [:]
        userid = ""
        selectedDate = ""
    isLoggedin = false
    username = ""
    userage = ""
    useremail = ""
    usersex = ""
    userweight = ""
        
        datevalue = ""
workoutsetNumber = 0
        duration = 0
        noOfSteps = 0
        workoutSource = ""
        stepsSource = ""
        
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        today = formatter.string(from: currentDateTime)
        //today = "Apr 10, 2017"
    }
}
