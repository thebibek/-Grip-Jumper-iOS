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

struct SettingsScenes {

    //MARK: - Global Scene Settings
    struct Global {
        struct FontColor {
            static let leaberboardCellText = "#ffffff"
            static let leaberboardBackgroundAlpha: CGFloat = 0.35 //From 0.0 to 1.0
            static let leaberboardBackground = "#ffffff"
        }
    }
    
    //MARK: - Game Scene Settings
    struct Game {
        struct Size {
            static let background = CGSize.withPercent(100, height: 100)
            static let interfaceHolder = CGSize.withPercent(200, height: 200)
            static let pauseBackground = CGSize.withPercent(100, height: 100)
            
            static let coinsIndicator = CGSize.withPercentScaled(4, height: 4)
            
            static let buttonPause = CGSize.withPercentScaled(roundByWidth: 10)
            static let buttonRestart = CGSize.withPercentScaled(roundByWidth: 12)
            static let buttonMenu = CGSize.withPercentScaled(roundByWidth: 12)
            static let buttonContinue = CGSize.withPercentScaled(roundByWidth: 12)
            
            static let player = CGSize.withPercentScaled(12.1, height: 12.1)
            static let hat = CGSize.withPercentScaled(12.1, height: 12.1)
            static let explosion = CGSize.withPercentScaled(roundByWidth: 5)
            static let enemy = CGSize.withPercentScaled(12.1, height: 12.1)
            static let coin = CGSize.withPercentScaled(roundByWidth: 5)
            
            static let textPause = CGSize.withPercentScaled(26.7, height: 14.8)
        }
        
        struct Position {
            static let background = CGPoint.withPercent(50, y: 50)
            static let interfaceHolder = CGPoint.withPercent(0, y: 0)
            static let pauseBackground = CGPoint.withPercent(50, y: 50)
            
            static let coinsIndicator = CGPoint.withPercent(84, y: 93)
            
            static let buttonPause = CGPoint.withPercent(10, y: 93)
            static let button_Restart_Menu_Continue = CGPoint.withPercent(50, y: 50)
            static let space_Button_Restart_Menu_Continue = SettingsGlobal.width / 100 * 1.75
            
            static let labelScore = CGPoint.withPercent(50, y: 87)
            static let labelCoins = CGPoint.withPercent(86.5, y: 93)
            
            static let player = CGPoint.withPercent(50, y: 20)
            static let hat = CGPoint.withPercent(0, y: 0)
            static let enemy = CGPoint.withPercent(50, y: 75)
            static let coin = CGPoint.withPercent(50, y: 50)
            
            static let textPause = CGPoint.withPercent(50, y: 74)
        }
        
        struct ZPosition {
            static let background: CGFloat = 0
            static let interfaceHolder: CGFloat = 100
            static let pauseBackground: CGFloat = 500
            
            static let coinsIndicator: CGFloat = 1
            
            static let buttonPause: CGFloat = 499
            static let buttonRestart: CGFloat = 501
            static let buttonMenu: CGFloat = 501
            static let buttonContinue: CGFloat = 501
            
            static let labelScore: CGFloat = 2
            static let labelCoins: CGFloat = 2
            
            static let player: CGFloat = 10
            static let hat: CGFloat = 1
            static let explosion: CGFloat = 11
            static let enemy: CGFloat = 9
            static let coin: CGFloat = 8
            
            static let textPause: CGFloat = 501
        }
        
        struct FontSize {
            static let labelScore: CGFloat = 50
            static let labelCoins: CGFloat = 16
        }
        
        struct FontColor {
            static let labelScore = "#ffffff"
            static let labelCoins = "#ffffff"
        }
    }
    
    //MARK: - Menu Scene Settings
    struct Menu {
        struct Size {
            static let background = CGSize.withPercent(100, height: 100)
            static let logo = CGSize.withPercentScaled(75, height: 44.9)
            
            static let coinsIndicator = CGSize.withPercentScaled(4, height: 4)
            
            static var buttonStart = CGSize.withPercentScaled(roundByWidth: 32)
            static let buttonStartIPad = CGSize.withPercentScaled(roundByWidth: 25)
            static let buttonStore = CGSize.withPercentScaled(roundByWidth: 11)
            static let buttonRateUs = CGSize.withPercentScaled(roundByWidth: 11)
            static let buttonTutorial = CGSize.withPercentScaled(roundByWidth: 11)
            static let buttonGameCenter = CGSize.withPercentScaled(roundByWidth: 11)
            static let buttonSettings = CGSize.withPercentScaled(roundByWidth: 11)
            
            static let indicatorButtonStore = CGSize.withPercentScaled(roundByWidth: 3.4)
        }
        
        struct Position {
            static let background = CGPoint.withPercent(50, y: 50)
            static let logo = CGPoint.withPercent(50, y: 74)
            
            static let coinsIndicator = CGPoint.withPercent(5, y: 10.25)
            
            static let buttonStart = CGPoint.withPercent(50, y: 39)
            static let buttonStore = CGPoint.withPercent(74, y: 39)
            static let buttons_RateUs_Tutorial_GameCenter_Settings = CGPoint.withPercent(50, y: 25)
            static let space_Buttons_RateUs_Tutorial_GameCenter_Settings = SettingsGlobal.width / 100 * 1.25
            
            static let indicatorButtonStore = CGPoint.withPercentScaledByWidth(4.9, y: 4.9)
            
            static let labelBestScore = CGPoint.withPercent(3, y: 13.5)
            static let labelCoins = CGPoint.withPercent(8, y: 10.25)
            static let labelWorldBestScoreName = CGPoint.withPercent(97, y: 10.25)
            static let labelWorldBestScoreValue = CGPoint.withPercent(97, y: 13.25)
        }
        
        struct ZPosition {
            static let background: CGFloat = 0
            static let logo: CGFloat = 1
            
            static let coinsIndicator: CGFloat = 1
            
            static let buttonStart: CGFloat = 2
            static let buttonStore: CGFloat = 2
            static let buttonRateUs: CGFloat = 2
            static let buttonTutorial: CGFloat = 2
            static let buttonGameCenter: CGFloat = 2
            static let buttonSettings: CGFloat = 2
            
            static let indicatorButtonStore: CGFloat = 1
            
            static let labelBestScore: CGFloat = 3
            static let labelCoins: CGFloat = 3
            static let labelWorldBestScoreName: CGFloat = 3
            static let labelWorldBestScoreValue: CGFloat = 3
        }
        
        struct FontSize {
            static let labelBestScore: CGFloat = 16
            static let labelCoins: CGFloat = 16
            static let labelWorldBestScoreName: CGFloat = 16
            static let labelWorldBestScoreValue: CGFloat = 16
        }
        
        struct FontColor {
            static let labelBestScore = "#ffffff"
            static let labelCoins = "#ffffff"
            static let labelWorldBestScoreName = "#ffffff"
            static let labelWorldBestScoreValue = "#ffffff"
        }
    }
    
    //MARK: - End Scene Settings
    struct End {
        struct Size {
            static let background = CGSize.withPercent(100, height: 100)
            static let logo = CGSize.withPercentScaled(75, height: 44.9)
            
            static let coinsIndicator = CGSize.withPercentScaled(roundByWidth: 4)
            
            static let buttonMenu = CGSize.withPercentScaled(roundByWidth: 11)
            static let buttonRestart = CGSize.withPercentScaled(roundByWidth: 13)
            static let buttonShare = CGSize.withPercentScaled(roundByWidth: 11)
            static let buttonGameCenter = CGSize.withPercentScaled(roundByWidth: 11)
        }
        
        struct Position {
            static let background = CGPoint.withPercent(50, y: 50)
            static let logo = CGPoint.withPercent(50, y: 74)
            
            static let coinsIndicator = CGPoint.withPercent(46, y: 10)
            
            static let labelScore = CGPoint.withPercent(50, y: 17)
            static let labelBestScore = CGPoint.withPercent(50, y: 14)
            static let labelCoins = CGPoint.withPercent(48.5, y: 10)
            
            static var button_Menu_Restart = CGPoint.withPercent(16, y: 30)
            static var space_button_Menu_Restart = SettingsGlobal.width / 100 * 1.75
            static var button_Share_GameCenter = CGPoint.withPercent(84, y: 30)
            static var space_button_Share_GameCenter = SettingsGlobal.width / 100 * 1.75
        }
        
        struct ZPosition {
            static let background: CGFloat = 0
            static let logo: CGFloat = 1
            
            static let coinsIndicator: CGFloat = 2
            
            static let labelScore: CGFloat = 3
            static let labelBestScore: CGFloat = 3
            static let labelCoins: CGFloat = 3
            
            static let buttonMenu: CGFloat = 2
            static let buttonRestart: CGFloat = 2
            static let buttonShare: CGFloat = 2
            static let buttonGameCenter: CGFloat = 2
        }
        
        struct FontSize {
            static let labelScore: CGFloat = 16
            static let labelBestScore: CGFloat = 16
            static let labelCoins: CGFloat = 16
        }
        
        struct FontColor {
            static let labelScore = "#ffffff"
            static let labelBestScore = "#ffffff"
            static let labelCoins = "#ffffff"
        }
    }
    
    //MARK: - Settings Scene Settings
    struct Settings {
        struct Size {
            static let background = CGSize.withPercent(100, height: 100)
            
            static let switchSound = CGSize.withPercentScaled(16, height: 8)
            static let switchMusic = CGSize.withPercentScaled(16, height: 8)
            static let switchNotification = CGSize.withPercentScaled(16, height: 8)
            static let switchSoundDot = CGSize.withPercentScaled(6, height: 6)
            static let switchMusicDot = CGSize.withPercentScaled(6, height: 6)
            static let switchNotificationDot = CGSize.withPercentScaled(6, height: 6)
            
            static let textSettings = CGSize.withPercentScaled(40.5, height: 13.8)
            
            static let buttonBack = CGSize.withPercentScaled(roundByWidth: 11)
        }
        
        struct Position {
            static let background = CGPoint.withPercent(50, y: 50)
            
            static let switch_Sound_Music_Notification = CGPoint.withPercent(68, y: 50)
            static let space_Sound_Music_Notification = SettingsGlobal.width / 100 * 7
            static let switchDotOn = CGPoint.withPercent(4, y: 0)
            
            static let buttonBack = CGPoint.withPercent(50, y: 20)
            
            static let textSettings = CGPoint.withPercent(50, y: 86)
            
            static let label_Sound_Music_Notification = CGPoint.withPercent(57, y: 50)
        }
        
        struct ZPosition {
            static let background: CGFloat = 0
            
            static let switchSound: CGFloat = 1
            static let switchMusic: CGFloat = 1
            static let switchNotification: CGFloat = 1
            static let switchDot: CGFloat = 1
            
            static let buttonBack: CGFloat = 3
            
            static let textSettings: CGFloat = 5
            
            static let labelSound: CGFloat = 2
            static let labelMusic: CGFloat = 2
            static let labelNotification: CGFloat = 2
        }
        
        struct FontSize {
            static let labelSound: CGFloat = 19
            static let labelMusic: CGFloat = 19
            static let labelNotification: CGFloat = 19
        }
        
        struct FontColor {
            static let labelSound = "#ffffff"
            static let labelMusic = "#ffffff"
            static let labelNotification = "#ffffff"
        }
    }
    
    //MARK: - Store Scene Settings
    struct Store {
        struct Size {
            static let background = CGSize.withPercent(100, height: 100)
            static let buyResult = CGSize.withPercent(100, height: 100)
            
            static let coinsIndicator = CGSize.withPercentScaled(roundByWidth: 4)
            
            static let buttonBack = CGSize.withPercentScaled(11, height: 11)
            
            static let buttonSkinNext = CGSize.withPercentScaled(11, height: 11)
            static let buttonSkinPrevious = CGSize.withPercentScaled(11, height: 11)
            static let buttonSelector = CGSize.withPercentScaled(30, height: 13)
            
            static let buttonRemoveAds = CGSize.withPercentScaled(35, height: 10)
            static let buttonRestorePurchases = CGSize.withPercentScaled(35, height: 10)
            
            static let textStore = CGSize.withPercentScaled(28.3, height: 13.8)
        }
        
        struct Position {
            static let background = CGPoint.withPercent(50, y: 50)
            static let buyResult = CGPoint.withPercent(50, y: 50)
            
            static let coinsIndicator = CGPoint.withPercent(46, y: 79)
            
            static let buttonBack = CGPoint.withPercent(50, y: 20)
            
            static let buttonSkinNext = CGPoint.withPercent(80, y: 50)
            static let buttonSkinPrevious = CGPoint.withPercent(20, y: 50)
            static let buttonSelector = CGPoint.withPercent(50, y: 33)
            
            static let skinHolder = CGPoint.withPercent(50, y: 50)
            static let skinHolderSkinShift = SettingsGlobal.width / 100 * 23
            static let skinHolderSkinShiftNonSelectedByY = SettingsGlobal.width / 100 * 15
            
            static let buttonRemoveAds = CGPoint.withPercent(26.5, y: 10.2)
            static let buttonRestorePurchases = CGPoint.withPercent(73.5, y: 10.2)
            static let buttonRemoveAdsIfOnOnlyInApps = CGPoint.withPercent(26.5, y: 45)
            static let buttonRestorePurchasesIfOnOnlyInApps = CGPoint.withPercent(73.5, y: 45)
            
            static let textStore = CGPoint.withPercent(50, y: 86)
            
            static let labelCoins = CGPoint.withPercent(49, y: 79)
            static let labelPrice = CGPoint.withPercent(3, y: 0)
        }
        
        struct ZPosition {
            static let background: CGFloat = 0
            static let buyResult: CGFloat = 10
            
            static let coinsIndicator: CGFloat = 2
            
            static let buttonBack: CGFloat = 1
            
            static let buttonSkinNext: CGFloat = 9
            static let buttonSkinPrevious: CGFloat = 9
            static let buttonSelector: CGFloat = 9
            
            static let skinHolder: CGFloat = 4
            
            static let buttonRemoveAds: CGFloat = 25
            static let buttonRestorePurchases: CGFloat = 25
            
            static let textStore: CGFloat = 10
            
            static let labelCoins: CGFloat = 3
            static let labelPrice: CGFloat = 1
        }
        
        struct FontSize {
            static let labelCoins: CGFloat = 16
            static let labelPrice: CGFloat = 30
        }
        
        struct FontColor {
            static let labelCoins = "#ffffff"
            static let labelPrice = "#ffffff"
        }
    }
    
    //MARK: - Tutorial Scene Settings
    struct Tutorial {
        struct Size {
            static let background = CGSize.withPercent(100, height: 100)
            
            static let indicatorCloseTutorial = CGSize.withPercentScaled(100, height: 14.3)
        }
        
        struct Position {
            static let background = CGPoint.withPercent(50, y: 50)
        }
        
        struct ZPosition {
            static let background: CGFloat = 0
            
            static let indicatorCloseTutorial: CGFloat = 2
        }
    }
}
