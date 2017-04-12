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
    var username:String
    var userage:String
    var useremail:String
    var usersex:String
    var userweight:String
    var userDict :[String:Any]
    private init(){
        userDict = [:]
    isLoggedin = false
    username = ""
    userage = ""
    useremail = ""
    usersex = ""
    userweight = ""

        
    }
}
