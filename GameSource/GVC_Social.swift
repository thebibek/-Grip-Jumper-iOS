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

import StoreKit

extension GameViewController {
    
    //Share
    /** Call this for use sharing function.*/
    @objc func share() {
        ///Get stats
        let text: String  = SettingsGlobal.SomeSocialStats.shareText
        let dataImage: Data = UserDefaults.standard.object(forKey: "ScreenShot") as! Data
        let image: UIImage = UIImage(data: dataImage)!
        let shareItems: Array = [image, text] as [Any]
        
        ///Create alert
        let activityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = view;
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.print, UIActivity.ActivityType.postToWeibo, UIActivity.ActivityType.copyToPasteboard, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.postToVimeo]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    //MARK: - RateUs
    /** Call this in the end of game for view rate us allert.*/
    @objc func rateUsAfterGame() {
        if !UserDefaults.standard.bool(forKey: "neverRateAfterGame") {
            callRateUsAlert(withTypeAutomatically: true)
        }
    }
    
    /** Call this for manually rate us alert.*/
    @objc func rateUs() {
        callRateUsAlert(withTypeAutomatically: false)
    }
    
    fileprivate func callRateUsAlert(withTypeAutomatically type: Bool) {
        ///New style alert
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
            if type { UserDefaults.standard.set(true, forKey: "neverRateAfterGame")}
        }
        ///Alert for old verison iOS
        else {
            ///Create alert
            let alert = UIAlertController(title: "Rate Us", message: type ? "Thanks for playing" : "If you like this game rate it in AppStore", preferredStyle: UIAlertController.Style.alert)
            ///Create buttons
            alert.addAction(UIAlertAction(title: type ? "Ok" : "Rate", style: UIAlertAction.Style.default, handler: { alertAction in
                UserDefaults.standard.set(true, forKey: "neverRateAfterGame")
                UIApplication.shared.openURL(URL(string : SettingsGlobal.SomeSocialStats.linkToRateUs)!)
                alert.dismiss(animated: true, completion: nil)
            }))
            if type {
                alert.addAction(UIAlertAction(title: "No Thanks", style: UIAlertAction.Style.default, handler: { alertAction in
                    UserDefaults.standard.set(true, forKey: "neverRateAfterGame")
                    alert.dismiss(animated: true, completion: nil)
                }))
            }
            alert.addAction(UIAlertAction(title: type ? "Maybe Later" : "Cancel", style: type ? UIAlertAction.Style.default : UIAlertAction.Style.cancel, handler: { alertAction in
                alert.dismiss(animated: true, completion: nil)
            }))
            ///Show
            present(alert, animated: true, completion: nil)
        }
    }
}
