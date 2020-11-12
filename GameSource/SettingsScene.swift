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

class SettingsScene: GlobalScene, SwitchNodeDelegate {
    
    //MARK: Nodes
    fileprivate let background = BackgroundNode()
    
    fileprivate let switchSound = SwitchNode(texture: GraphicPreloadsInterface.preload.switch_Body, size: SettingsScenes.Settings.Size.switchSound, zPosition: SettingsScenes.Settings.ZPosition.switchSound, textureDot: GraphicPreloadsInterface.preload.switch_Dot, sizeDot: SettingsScenes.Settings.Size.switchSoundDot, positionDot: SettingsScenes.Settings.Position.switchDotOn, zPositionDot: SettingsScenes.Settings.ZPosition.switchDot)
    fileprivate let switchMusic = SwitchNode(texture: GraphicPreloadsInterface.preload.switch_Body, size: SettingsScenes.Settings.Size.switchMusic, zPosition: SettingsScenes.Settings.ZPosition.switchMusic, textureDot: GraphicPreloadsInterface.preload.switch_Dot, sizeDot: SettingsScenes.Settings.Size.switchMusicDot, positionDot: SettingsScenes.Settings.Position.switchDotOn, zPositionDot: SettingsScenes.Settings.ZPosition.switchDot)
    fileprivate let switchNotification = SwitchNode(texture: GraphicPreloadsInterface.preload.switch_Body, size: SettingsScenes.Settings.Size.switchNotification, zPosition: SettingsScenes.Settings.ZPosition.switchNotification, textureDot: GraphicPreloadsInterface.preload.switch_Dot, sizeDot: SettingsScenes.Settings.Size.switchNotificationDot, positionDot: SettingsScenes.Settings.Position.switchDotOn, zPositionDot: SettingsScenes.Settings.ZPosition.switchDot)
    
    fileprivate let buttonBack = ButtonNode(defaultWithType: .back)
    
    fileprivate let labelSound = SimpleLabel(text: "Play Sounds", fontSize: SettingsScenes.Settings.FontSize.labelSound, fontColorHex: SettingsScenes.Settings.FontColor.labelSound, position: SettingsScenes.Settings.Position.label_Sound_Music_Notification, zPosition: SettingsScenes.Settings.ZPosition.labelSound)
    fileprivate let labelMusic = SimpleLabel(text: "Play Music", fontSize: SettingsScenes.Settings.FontSize.labelMusic, fontColorHex: SettingsScenes.Settings.FontColor.labelMusic, position: SettingsScenes.Settings.Position.label_Sound_Music_Notification, zPosition: SettingsScenes.Settings.ZPosition.labelMusic)
    fileprivate let labelNotification = SimpleLabel(text: "Notifications", fontSize: SettingsScenes.Settings.FontSize.labelNotification, fontColorHex: SettingsScenes.Settings.FontColor.labelNotification, position: SettingsScenes.Settings.Position.label_Sound_Music_Notification, zPosition: SettingsScenes.Settings.ZPosition.labelNotification)
    
    fileprivate let textSettings = SimpleNode(texture: GraphicPreloadsInterface.preload.textSettings, size: SettingsScenes.Settings.Size.textSettings, position: SettingsScenes.Settings.Position.textSettings, zPosition: SettingsScenes.Settings.ZPosition.textSettings)
    
    //MARK: - Scene life cycle
    override func didMove(to view: SKView) {
        ///Setting node
        labelSound.horizontalAlignmentMode = .right
        labelMusic.horizontalAlignmentMode = .right
        labelNotification.horizontalAlignmentMode = .right
        InterfaceExtention.put(nodesWithArray: [switchSound, switchMusic, switchNotification], atPosition: SettingsScenes.Settings.Position.switch_Sound_Music_Notification, withSpaceBetween: SettingsScenes.Settings.Position.space_Sound_Music_Notification, andSortHorizontal: false)
        InterfaceExtention.mirrored(nodesToMirror: [labelSound, labelMusic, labelNotification], fromNodes: [switchSound, switchMusic, switchNotification], byX: false)
        
        textSettings.setInterfaceSize()
        
        switchSound.setSwitchState(UserDefaults.standard.bool(forKey: "PlaySounds"))
        switchMusic.setSwitchState(UserDefaults.standard.bool(forKey: "PlayMusic"))
        switchNotification.setSwitchState(UserDefaults.standard.bool(forKey: "NotificationOn"))
        switchSound.delegate = self
        switchMusic.delegate = self
        switchNotification.delegate = self
        
        ///Add nodes to view
        addChild([background, switchSound, switchMusic, switchNotification, buttonBack, labelSound, labelMusic, labelNotification, textSettings])
    }
    
    //MARK: - Logic
    /**
     This method it's delegate from SwitchNode class.
     If you try to change state of switch system call this method.
     Use it for change some game settings in game.
     */
    func switchStateIsChanged(_ sender: SwitchNode) {
        //Change states for some buttons
        switch sender {
        case switchSound: Sound.sharedInstance().changeStateSound()
        case switchMusic: Sound.sharedInstance().changeStateMusic()
        case switchNotification: ExternalFunctions.changeNotificationState()
        default: print("SettingsScenes - changeSwitchStatIsWasDone")
        }
    }
    
    //MARK: - Input
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            ///Check press to switch
            switchSound.changeSwitchState(ifInLocation: location)
            switchMusic.changeSwitchState(ifInLocation: location)
            switchNotification.changeSwitchState(ifInLocation: location)
            
            ///Check press to button
            touchDownButtons(atLocation: location)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            ///Change button state to simple
            touchUpAllButtons()
            
            buttonBack.actionChangeScene(ifInLocation: location, withTransition: .pushLeft)
        }
    }
}
