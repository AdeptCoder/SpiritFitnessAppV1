//
//  SingletonClass.swift
//  SpiritFitnessApp_Team4_SwiftProject
//
//  Created by Sumirna Philips on 4/4/17.
//  Copyright © 2017 19483. All rights reserved.
//

import Foundation

class SingletonClass{
    
    static let shared = SingletonClass()
    var isAlreadyLaunchedOnce:Bool
    var isLoggedin:Bool
    var username:String
    var userage:String
    var useremail:String
    var usersex:String
    var userweight:String
    
    private init(){
    isAlreadyLaunchedOnce = false
    isLoggedin = false
    username = ""
    userage = ""
    useremail = ""
    usersex = ""
    userweight = ""

        
    }
}
