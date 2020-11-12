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

class AdController {
    
    //MARK: - Work with ads
    /** Load ads*/
    class func loadAdsForScene(_ name: GlobalScene.SceneName) {
        if SettingsGlobal.Ad.on {
            ///Check ads removed by in-app
            if !UserDefaults.standard.bool(forKey: "adRemovedByPurchase") {
                var showInterstitial = false
                var showBanner = false
                
                ///Load settings
                switch name {
                case .end:
                    showInterstitial = SettingsGlobal.Ad.Showing.Interstitial.end
                    showBanner = SettingsGlobal.Ad.Showing.Banner.end
                case .game:
                    showInterstitial = SettingsGlobal.Ad.Showing.Interstitial.game
                    showBanner = SettingsGlobal.Ad.Showing.Banner.game
                case .menu:
                    showInterstitial = SettingsGlobal.Ad.Showing.Interstitial.menu
                    showBanner = SettingsGlobal.Ad.Showing.Banner.menu
                case .settings:
                    showInterstitial = SettingsGlobal.Ad.Showing.Interstitial.settings
                    showBanner = SettingsGlobal.Ad.Showing.Banner.settings
                case .store:
                    showInterstitial = SettingsGlobal.Ad.Showing.Interstitial.store
                    showBanner = SettingsGlobal.Ad.Showing.Banner.store
                case .tutorial:
                    showInterstitial = SettingsGlobal.Ad.Showing.Interstitial.tutorial
                    showBanner = SettingsGlobal.Ad.Showing.Banner.tutorial
                }
                
                ///Don't show intertitial at first time
                if !UserDefaults.standard.bool(forKey: "showInterstatialAtFirstTime") {
                    UserDefaults.standard.set(true, forKey: "showInterstatialAtFirstTime")
                    showInterstitial = false
                }
                
                ///Load ads
                if showInterstitial { setInterstitial()}
                changeBannerState(toVisible: showBanner)
            }
        }
    }
    
    /** Show interstitial.*/
    class fileprivate func setInterstitial() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "showInterstitial"), object: nil)
        Debugger.printNow(textToPrint: "Try to show interstitial")
    }
    
    /** Change banner state.*/
    class fileprivate func changeBannerState(toVisible visible: Bool) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: visible ? "showBanner" : "hideBanner"), object: nil)
        Debugger.printNow(textToPrint: "Banner change state")
    }
}
