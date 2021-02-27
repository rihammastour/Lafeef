//
//  Constants.swift
//  LoginDemo
//
//  Created by Renad nasser on 26/01/2021.
//  Copyright © 2021 Renad Nasser. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Storyboard {
        static let profileViewController = "ProfileVC"
        static let challengeLevelsViewController = "ChallengeLevelsVC"
        static let challengeViewController = "ChallengeVC"
        static let homeViewController = "HomeVC"
        static let loginViewController = "LoginVC"
        static let signUpOrLoginViewController = "signUpOrLoginVC"
        static let homeNavigationController = "HomeNavigation"
        static let animatedSplashViewController = "animatedSplashVC"
        static let timerViewController = "TimerVC"
        static let orderVirwController = "OrderVC"
        static let dailyReportViewController = "DailyReportVC"
        static let advReportViewController = "AdvReportVC"
    }
    
    struct Segue {
        static let signUpOrLoginSegue = "SignupOrLoginSegue"
        static let homeSegue = "HomeSegue"
        static let signupSegue = "SignupSegue"
        static let challengeSegue = "challengeSegue"
        static let menuSegue = "MenuSegue"
        static let continueGame = "ContinueGame"
        static let rejectAdvSegue = "RejectAdvSegue"
        static let acceptAdvSegue = "AcceptAdvSegue"
        static let showDailyReport = "ShowDailyReport"
        static let showLosingReport = "ShowLosingReport"
        static let showRewardReport = "ShowRewardReport"
        static let showAdvReport = "ShowAdvReport"
    }
    
}
