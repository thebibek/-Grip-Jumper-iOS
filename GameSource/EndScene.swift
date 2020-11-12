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

class EndScene: GlobalScene {
    
    //MARK: Nodes
    fileprivate let background = BackgroundNode()
    fileprivate let logo = LogoNode(withType: .menu)
    
    fileprivate let coinsIndicator = SimpleNode(texture: GraphicPreloadsInterface.preload.coinsIndicator, size: SettingsScenes.End.Size.coinsIndicator, position: SettingsScenes.End.Position.coinsIndicator, zPosition: SettingsScenes.End.ZPosition.coinsIndicator)
    
    fileprivate let labelScore = SimpleLabel(text: "Current Score: " + String(UserDefaults.standard.integer(forKey: "CurrentScore")), fontSize: SettingsScenes.End.FontSize.labelScore, fontColorHex: SettingsScenes.End.FontColor.labelScore, position: SettingsScenes.End.Position.labelScore, zPosition: SettingsScenes.End.ZPosition.labelScore)
    fileprivate let labelBestScore = SimpleLabel(text: "Best Score: " + String(UserDefaults.standard.integer(forKey: "BestScore")), fontSize: SettingsScenes.End.FontSize.labelBestScore, fontColorHex: SettingsScenes.End.FontColor.labelBestScore, position: SettingsScenes.End.Position.labelBestScore, zPosition: SettingsScenes.End.ZPosition.labelBestScore)
    fileprivate let labelCoins = SimpleLabel(text: String(UserDefaults.standard.integer(forKey: "Coins")), fontSize: SettingsScenes.End.FontSize.labelCoins, fontColorHex: SettingsScenes.End.FontColor.labelCoins, position: SettingsScenes.End.Position.labelCoins, zPosition: SettingsScenes.End.ZPosition.labelCoins)
    
    fileprivate let buttonMenu = ButtonNode(defaultWithType: .menu)
    fileprivate let buttonRestart = ButtonNode(defaultWithType: .restart)
    fileprivate let buttonShare = ButtonNode(defaultWithType: .share)
    fileprivate let buttonGameCenter = ButtonNode(defaultWithType: .gameCenter)
    
    //MARK: - Scene life cycle
    override func didMove(to view: SKView) {
        ///Work with some external functions.
        ExternalFunctions.getLeaderboard()
        ExternalFunctions.getWorldBestScore()
        ExternalFunctions.rateUsAfterGame()
        
        InterfaceExtention.put(nodesWithArray: [buttonMenu, buttonRestart], atPosition: SettingsScenes.End.Position.button_Menu_Restart, withSpaceBetween: SettingsScenes.End.Position.space_button_Menu_Restart, andSortHorizontal: false)
        InterfaceExtention.put(nodesWithArray: [buttonShare, buttonGameCenter], atPosition: SettingsScenes.End.Position.button_Share_GameCenter, withSpaceBetween: SettingsScenes.End.Position.space_button_Share_GameCenter, andSortHorizontal: false)
        
        ///Settings node
        labelCoins.horizontalAlignmentMode = .left
        if UserDefaults.standard.bool(forKey: "_newBestScore") {
            labelScore.text = "You set new best score!"
        }
        
        logo.setInterfaceSize()
        coinsIndicator.setInterfaceSize()
        
        ///Add node to scene
        addChild([background, logo, labelScore, labelBestScore, buttonMenu, buttonRestart, buttonShare, buttonGameCenter])
        if SettingsGlobal.Skins.on { addChild([coinsIndicator, labelCoins])}
        
        runAnimations()
    }
    
    //MARK: - Animations
    /** Run start scene animations*/
    fileprivate func runAnimations() {
        if SettingsGameProcess.Interface.End.sceneInterfaceAnimationOn {
            buttonRestart.repeatActionPulse(toSize: SettingsGameProcess.Interface.End.buttonRestartPulseTo, time: SettingsGameProcess.Interface.End.buttonRestartPulseSpeed)
        }
    }
    
    //MARK: - Input
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            touchDownButtons(atLocation: location)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            ///Change button state to simple
            touchUpAllButtons()
            
            if buttonMenu.contains(location) || buttonRestart.contains(location) {
                ExternalFunctions.hideLeaderboard()
                buttonMenu.actionChangeScene(ifInLocation: location, withTransition: .pushRight)
                buttonRestart.actionChangeScene(ifInLocation: location, withTransition: .pushRight)
            }
            buttonShare.actionShare(ifInLocation: location)
            buttonGameCenter.actionShowGameCenter(ifInLocation: location)
        }
    }
}
