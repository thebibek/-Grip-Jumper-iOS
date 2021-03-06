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

/**
 This struch have constant settigns values for global project (It's used in different parts of game)
 */
struct SettingsGlobal {
    
    /** AdMob settings.*/
    struct Ad {
        static let on = true
        static let testDeviceID = "0fae75abcceb5d496cdde66a3ea24dea"
        
        static let idInterstitial = "ca-app-pub-3940256099942544/4411468910"
        static let idBanner = "ca-app-pub-3940256099942544/2934735716"
        
        /** Showing option. It's works when you just open some new scene in your game.*/
        struct Showing {
            struct Interstitial {
                static let game = false
                static let end = true
                static let menu = false
                static let settings = false
                static let store = false
                static let tutorial = false
            }
            
            struct Banner {
                static let game = false
                static let end = false
                static let menu = false
                static let settings = true
                static let store = false
                static let tutorial = false
            }
        }
    }
    
    /** In-Apps function for removing ad's from game.*/
    struct InApp {
        static let on = true
        static let removingAds = "removeAdsIDs"
    }
    
    /** Skin system for player also include coin system. Not available in some games.*/
    struct Skins {
        static let on = true
    }
    
    /** Pause function in game scene.*/
    struct Pause {
        static let on = true
    }
    
    /** GameCenter settings. Write here you leaderboard id's and other.*/
    struct GameCenter {
        static let testMode = true //Turn off test mode when you upload game to AppStore
        static let leaderboard = "Leaderboard"
    }
    
    /** Some social info.*/
    struct SomeSocialStats {
        static let shareText = "Try to beat my score!"
        static let linkToRateUs = "http://google.com/"
    }
    
    /** Global information for scenes*/
    struct WorkWithScenes {
        static let fontNameInGame = "DINCondensed-Bold"
        static let speedOfChangeScene: Double = 0.8
        
        /** Change it value if you make pixel art game. And textures in app game not been filtered.*/
        static let filteredImagesInGame = true
    }
    
    /** Size of screen width */
    static let width = CGFloat(UserDefaults.standard.float(forKey: "SizeWidth"))
    /** Size of screen height */
    static let height = CGFloat(UserDefaults.standard.float(forKey: "SizeHeight"))
    
    static let isXPhone = UserDefaults.standard.bool(forKey: "_isXPhone")
    static let isIPad = UserDefaults.standard.bool(forKey: "_isIPad")
    
    static let debugMode = true
}
