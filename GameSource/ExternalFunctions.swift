/*
 
 Created by TapTapStudio (Alice Vinnik).
 Copyright ©2020 TapTapStudio. All rights reserved.

 ▀▀█▀▀ ░█▀▀█ ▒█▀▀█ ▀▀█▀▀ ░█▀▀█ ▒█▀▀█
 ░▒█░░ ▒█▄▄█ ▒█▄▄█ ░▒█░░ ▒█▄▄█ ▒█▄▄█
 ░▒█░░ ▒█░▒█ ▒█░░░ ░▒█░░ ▒█░▒█ ▒█░░░

 ▒█▀▀▀█ ▀▀█▀▀ ▒█░▒█ ▒█▀▀▄ ▀█▀ ▒█▀▀▀█
 ░▀▀▀▄▄ ░▒█░░ ▒█░▒█ ▒█░▒█ ▒█░ ▒█░░▒█
 ▒█▄▄▄█ ░▒█░░ ░▀▄▄▀ ▒█▄▄▀ ▄█▄ ▒█▄▄▄█
 
 If you want reskin write me.
 Here you can see reskin examples 🌅: https://alicevinnik.wixsite.com/taptapstudio
 Subscribe to my instagram 📷: https://www.instagram.com/taptap_studio/
 Write to my mail 💌: taptap.main@gmail.com
 
*/

import Foundation

/**
 This class can help you call some non SpriteKit functions.
 It's func described in GameViewController
 */
class ExternalFunctions {
    
    //MARK: - Game Center
    static func showLeaderboard() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "showLeaderboard"), object: nil)
    }
    
    static func getLeaderboard() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "getLeaderboard"), object: nil)
    }
    
    static func hideLeaderboard() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "hideGameScoreTableView"), object: nil)
    }
    
    static func submitScore() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "submitScore"), object: nil)
    }
    
    static func getWorldBestScore() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "getWorldBestScore"), object: nil)
    }
    
    //MARK: - Rate Us
    static func rateUs() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "rateUs"), object: nil)
    }
    
    static func rateUsAfterGame() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "rateUs"), object: nil)
    }
    
    //MARK: - Sharing
    static func share() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "share"), object: nil)
    }
    
    //MARK: - In-Apps
    static func buyRemoveAds() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "buyRemoveAds"), object: nil)
    }
    
    static func restorePurchases() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "restorePurchases"), object: nil)
    }
    
    //MARK: - Notifications
    static func changeNotificationState() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "changeNotificationState"), object: nil)
    }
}
