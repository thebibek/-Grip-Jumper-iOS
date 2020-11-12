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

import SpriteKit
import StoreKit
import GoogleMobileAds

extension GameViewController {
    
    //MARK: - Settings
    /** It's first settings when you install game at first time.*/
    func firstLaunchSettings() {
        if !(UserDefaults.standard.bool(forKey: "HasLaunchedOnce")) {
            UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
            
            //Set stats
            ///Music
            UserDefaults.standard.set(true, forKey: "PlaySounds")
            UserDefaults.standard.set(true, forKey: "PlayMusic")
            
            ///Notifications
            UserDefaults.standard.set(true, forKey: "NotificationOn")
            UserDefaults.standard.set(false, forKey: "neverRateAfterGame")
            
            ///Skins
            UserDefaults.standard.set(1, forKey: "CurrentSkin")
            UserDefaults.standard.set(SettingsGameProcess.Coin.atFirstLaunch, forKey: "Coins")
            
            ///Game Process
            UserDefaults.standard.set(false, forKey: "TutorialWasShown")
            UserDefaults.standard.set(false, forKey: "TutorialOpenedWhenPressToStart")
            UserDefaults.standard.set(0, forKey: "CurrentScore")
            UserDefaults.standard.set(0, forKey: "BestScore")
            
            ///Ads and In-Apps
            UserDefaults.standard.set(false, forKey: "showInterstatialAtFirstTime")
            UserDefaults.standard.set(false, forKey: "showVideoAtFirstTime")
            UserDefaults.standard.set(false, forKey: "adRemovedByPurchase")
            
            ///Load skin values
            SkinValues.loadValues()
        }
    }
    
    /** This settings set evey game launch.*/
    func everyLaunchSettings() {
        ///Check game version. Call rateUs message if user open new version of game.
        if String(describing: Bundle.main.infoDictionary!["CFBundleShortVersionString"]) != UserDefaults.standard.string(forKey: "lastLaunchVersion") {
            UserDefaults.standard.set(String(describing: Bundle.main.infoDictionary!["CFBundleShortVersionString"]), forKey: "lastLaunchVersion")
            UserDefaults.standard.set(false, forKey: "neverRateAfterGame")
        }
        
        ///Settings ads
        interstitial = GADInterstitial(adUnitID: SettingsGlobal.Ad.idInterstitial)
        let request = GADRequest()
        interstitial.load(request)
        interstitial = createAndLoadInterstitial()
        
        ///Set view values
        if let view = view as! SKView? {
            view.showsFPS = false
            view.showsNodeCount = false
            view.ignoresSiblingOrder = true
        }
        
        ///Detect device and device values
        detectDevice()
        setNewSettingsForCurrentDevice()
        
        ///Other game stats
        UserDefaults.standard.set(0, forKey: "_currentSceneLoaded")
        
        ///Preload graphic files
        _ = GraphicPreloadsGame.preload
        _ = GraphicPreloadsInterface.preload
        
        ///Try to show ads in first loaded scene
        AdController.loadAdsForScene(.menu)
        
        ///Load world best score and work with gamecenter
        authenticateLocalPlayer()
        UserDefaults.standard.set(false, forKey: "GC_worldBestScore_PossibleToShow")
        getWorldBestScore()
        
        ///Notification setup
        sendNotifications()
        
        ///InApps setting
        if SettingsGlobal.InApp.on {
            requestProductData()
            SKPaymentQueue.default().add(self)
        }
        
        ///Create observer
        createObserversToGameSceneController()
    }
    
    //MARK: - Detect device
    /** Create GameViewController observers.*/
    fileprivate func detectDevice() {
        if UIDevice().userInterfaceIdiom == .phone {
            UserDefaults.standard.set(false, forKey: "_isIPad")
            
            var screenHeight = UIScreen.main.nativeBounds.height
            var screenWidth = UIScreen.main.nativeBounds.width
            if screenWidth > screenHeight {
                let catche = screenHeight
                screenHeight = screenWidth
                screenWidth = catche
            }
            
            let proportion = Double(screenHeight / screenWidth)
            if proportion < 2.0 {
                Debugger.printNow(textToPrint: "iPhone Simple")
                UserDefaults.standard.set(false, forKey: "_isXPhone")
            }
            else {
                Debugger.printNow(textToPrint: "iPhone X Type")
                UserDefaults.standard.set(true, forKey: "_isXPhone")
            }
        }
        else {
            Debugger.printNow(textToPrint: "iPad")
            UserDefaults.standard.set(false, forKey: "_isXPhone")
            UserDefaults.standard.set(true, forKey: "_isIPad")
        }
    }
    
    /** Change values for current device.*/
    func setNewSettingsForCurrentDevice() {
        ///If its iPhoneX type
        if SettingsGlobal.isXPhone {
            Debugger.printNow(textToPrint: "Load iPhone X type values")
        }
        ///If its iPad type
        if SettingsGlobal.isIPad {
            Debugger.printNow(textToPrint: "Load iPad type values")
        }
    }
    
    //MARK: - Observers
    /** Create GameViewController observers.*/
    func createObserversToGameSceneController() {
        ///Gamecenter
        NotificationCenter.default.addObserver(self, selector: #selector(showLeaderboard), name: NSNotification.Name(rawValue: "showLeaderboard"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(submitScore), name: NSNotification.Name(rawValue: "submitScore"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getLeaderboard), name: NSNotification.Name(rawValue: "getLeaderboard"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getWorldBestScore), name: NSNotification.Name(rawValue: "getWorldBestScore"), object: nil)
        
        ///Social
        NotificationCenter.default.addObserver(self, selector: #selector(share), name: NSNotification.Name(rawValue: "share"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(rateUs), name: NSNotification.Name(rawValue: "rateUs"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(rateUsAfterGame), name: NSNotification.Name(rawValue: "rateUsAfterGame"), object: nil)
        
        ///Ads
        NotificationCenter.default.addObserver(self, selector: #selector(showInterstitial), name: NSNotification.Name(rawValue: "showInterstitial"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showBanner), name: NSNotification.Name(rawValue: "showBanner"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideBanner), name: NSNotification.Name(rawValue: "hideBanner"), object: nil)
        
        ///Table View Leaderboard
        NotificationCenter.default.addObserver(self, selector: #selector(showGameScoreTableView), name: NSNotification.Name(rawValue: "showGameScoreTableView"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideGameScoreTableView), name: NSNotification.Name(rawValue: "hideGameScoreTableView"), object: nil)
        
        ///In-Apps
        NotificationCenter.default.addObserver(self, selector: #selector(buyRemoveAds), name: NSNotification.Name(rawValue: "buyRemoveAds"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(restorePurchases), name: NSNotification.Name(rawValue: "restorePurchases"), object: nil)
        
        ///Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(changeNotificationState), name: NSNotification.Name(rawValue: "changeNotificationState"), object: nil)
    }
}
