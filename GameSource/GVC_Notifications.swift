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

extension GameViewController {
    
    /** Call this for create notifications.*/
    func sendNotifications() {
        if UserDefaults.standard.bool(forKey: "NotificationOn") {
            UIApplication.shared.cancelAllLocalNotifications()
            
            ///Remember after 2 hours
            sendRandomNotification(fromArrayWithText: ["Play now!", "Beat your record!",
                                                       "Increase your results!", "Thanks for playing!"],
                                   showAfterSeconds: 7200)
            ///Remember after 6 hours
            sendRandomNotification(fromArrayWithText: ["Play now!", "You can better!",
                                                       "Play again!", "Hi"],
                                   showAfterSeconds: 21600)
            ///Remember after 22 hours
            sendRandomNotification(fromArrayWithText: ["Play one more time!", "Hello!",
                                                       "Play again!"],
                                   showAfterSeconds: 79200)
            ///Remember after 1 week
            sendNotification(withText: "It's wonderful day for playing!", showAfterSeconds: 604800)
        }
    }
    
    fileprivate func sendRandomNotification(fromArrayWithText arrayWithText: [String], showAfterSeconds timeToShow: Double) {
        let randomText = arrayWithText[Int(from: 0, to: arrayWithText.count - 1)]
        sendNotification(withText: randomText, showAfterSeconds: timeToShow)
    }
    
    fileprivate func sendNotification(withText text: String, showAfterSeconds timeToShow: Double) {
        let notification = UILocalNotification()
        notification.fireDate = Date(timeIntervalSinceNow: timeToShow)
        notification.alertBody = text
        notification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.shared.scheduleLocalNotification(notification)
    }
    
    /** Call this for change calling notification settings.*/
    @objc func changeNotificationState() {
        UserDefaults.standard.set(!UserDefaults.standard.bool(forKey: "NotificationOn"), forKey: "NotificationOn")
        
        if UserDefaults.standard.bool(forKey: "NotificationOn") { sendNotifications()}
        else { UIApplication.shared.cancelAllLocalNotifications()}
    }
}
