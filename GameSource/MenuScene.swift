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

class MenuScene: GlobalScene {
    
    //MARK: Nodes
    fileprivate var worldBestScoreAlreadyShowed = false
    
    fileprivate let background = BackgroundNode()
    fileprivate let logo = LogoNode(withType: .menu)
    
    fileprivate let coinsIndicator = SimpleNode(texture: GraphicPreloadsInterface.preload.coinsIndicator, size: SettingsScenes.Menu.Size.coinsIndicator, position: SettingsScenes.Menu.Position.coinsIndicator, zPosition: SettingsScenes.Menu.ZPosition.coinsIndicator)
    
    fileprivate let buttonStart = ButtonNode(defaultWithType: .start)
    fileprivate let buttonStore = ButtonNode(defaultWithType: .store)
    fileprivate let buttonRateUs = ButtonNode(defaultWithType: .rateUs)
    fileprivate let buttonTutorial = ButtonNode(defaultWithType: .tutorial)
    fileprivate let buttonGameCenter = ButtonNode(defaultWithType: .gameCenter)
    fileprivate let buttonSettings = ButtonNode(defaultWithType: .settings)
    
    fileprivate let indicatorButtonStore = SimpleNode(texture: GraphicPreloadsInterface.preload.indicatorButtonStore, size: SettingsScenes.Menu.Size.indicatorButtonStore, position: SettingsScenes.Menu.Position.indicatorButtonStore, zPosition: SettingsScenes.Menu.ZPosition.indicatorButtonStore)
    
    fileprivate let labelBestScore = SimpleLabel(text: "Your Best Score: " + String(UserDefaults.standard.integer(forKey: "BestScore")), fontSize: SettingsScenes.Menu.FontSize.labelBestScore, fontColorHex: SettingsScenes.Menu.FontColor.labelBestScore, position: SettingsScenes.Menu.Position.labelBestScore, zPosition: SettingsScenes.Menu.ZPosition.labelBestScore)
    fileprivate let labelCoins = SimpleLabel(text: String(UserDefaults.standard.integer(forKey: "Coins")), fontSize: SettingsScenes.Menu.FontSize.labelCoins, fontColorHex: SettingsScenes.Menu.FontColor.labelCoins, position: SettingsScenes.Menu.Position.labelCoins, zPosition: SettingsScenes.Menu.ZPosition.labelCoins)
    fileprivate let labelWorldBestScoreName = SimpleLabel(text: "", fontSize: SettingsScenes.Menu.FontSize.labelWorldBestScoreName, fontColorHex: SettingsScenes.Menu.FontColor.labelWorldBestScoreName, position: SettingsScenes.Menu.Position.labelWorldBestScoreName, zPosition: SettingsScenes.Menu.ZPosition.labelWorldBestScoreName)
    fileprivate let labelWorldBestScoreValue = SimpleLabel(text: "", fontSize: SettingsScenes.Menu.FontSize.labelWorldBestScoreValue, fontColorHex: SettingsScenes.Menu.FontColor.labelWorldBestScoreValue, position: SettingsScenes.Menu.Position.labelWorldBestScoreValue, zPosition: SettingsScenes.Menu.ZPosition.labelWorldBestScoreValue)
    
    //MARK: - Scene life cycle
    override func didMove(to view: SKView) {
        ///Settings node
        labelCoins.horizontalAlignmentMode = .left
        labelBestScore.horizontalAlignmentMode = .left
        labelWorldBestScoreName.horizontalAlignmentMode = .right
        labelWorldBestScoreValue.horizontalAlignmentMode = .right
        InterfaceExtention.put(nodesWithArray: [buttonRateUs, buttonTutorial, buttonGameCenter, buttonSettings],
                               atPosition: SettingsScenes.Menu.Position.buttons_RateUs_Tutorial_GameCenter_Settings,
                               withSpaceBetween: SettingsScenes.Menu.Position.space_Buttons_RateUs_Tutorial_GameCenter_Settings,
                               andSortHorizontal: true)
        
        logo.setInterfaceSize()
        coinsIndicator.setInterfaceSize()
        
        ///Add nodes to scene
        addChild([background, logo, buttonStart, buttonRateUs, buttonTutorial, buttonGameCenter, buttonSettings, labelBestScore, labelWorldBestScoreName, labelWorldBestScoreValue])
        if SettingsGlobal.InApp.on || SettingsGlobal.Skins.on {
            addChild(buttonStore)
            if SettingsGlobal.Skins.on {
                addChild([coinsIndicator, labelCoins])
            }
        }
        else { buttonStore.removeFromViewedPoint()}
        
        ///Cet coin indicator and run animations
        if UserDefaults.standard.integer(forKey: "Coins") >= SkinValues.getMinimalPrice() {
            if SettingsGameProcess.Interface.Menu.IndicatorStore.on {
                if SettingsGlobal.Skins.on {
                    buttonStore.addChild(indicatorButtonStore)
                    
                    indicatorButtonStore.run(SKAction.repeatForever(
                        SKAction.sequence([
                            SKAction.scale(to: SettingsGameProcess.Interface.Menu.IndicatorStore.scaleTo, duration: SettingsGameProcess.Interface.Menu.IndicatorStore.speed / 2),
                            SKAction.scale(to: 1.0, duration: SettingsGameProcess.Interface.Menu.IndicatorStore.speed / 2)])))
                }
            }
        }
        
        runAnimations()
    }
    
    override func update(_ currentTime: TimeInterval) {
        ///Try to show world best score
        updateLabelWorldBestScore()
    }
    
    /** Try to load world best score*/
    fileprivate func updateLabelWorldBestScore() {
        if !worldBestScoreAlreadyShowed {
            let animationShow = SKAction.sequence([
                SKAction.fadeAlpha(to: 0, duration: 0),
                SKAction.fadeAlpha(to: 1, duration: SettingsGameProcess.Interface.Menu.labelsWorldBestScoreAnimationShowSpeed)])
            
            if SettingsGlobal.GameCenter.testMode {
                labelWorldBestScoreValue.run(animationShow)
                labelWorldBestScoreName.run(animationShow)
                labelWorldBestScoreValue.text = "World Best Score: 326"
                labelWorldBestScoreName.text = "From Player: TapTap"
                
                worldBestScoreAlreadyShowed = true
            }
            else {
                if !worldBestScoreAlreadyShowed {
                    if UserDefaults.standard.bool(forKey: "GC_worldBestScore_PossibleToShow") {
                        labelWorldBestScoreValue.run(animationShow)
                        labelWorldBestScoreName.run(animationShow)
                        labelWorldBestScoreValue.text = "World Best Score: " + UserDefaults.standard.string(forKey: "GC_worldBestScore_Value_leaderboard")!
                        labelWorldBestScoreName.text = "From Player: " + UserDefaults.standard.string(forKey: "GC_worldBestScore_Name_leaderboard")!
                        
                        worldBestScoreAlreadyShowed = true
                    } else {
                        ExternalFunctions.getWorldBestScore()
                    }
                }
            }
        }
    }
    
    //MARK: - Scene animations
    /** Run start scene animations*/
    fileprivate func runAnimations() {
        if SettingsGameProcess.Interface.Menu.sceneInterfaceAnimationOn {
            let buttonStartDefaultPosition = buttonStart.position
            buttonStart.position = CGPoint(x: -100, y: buttonStart.position.y)
            let buttonStartAnimation = SKAction.sequence([
                SKAction.scale(to: SettingsGameProcess.Interface.Menu.StartButton.scaleAtStart, duration: 0),
                SKAction.group([
                    SKAction.rotateByDegree(-360, duration: SettingsGameProcess.Interface.Menu.StartButton.rotationSpeed),
                    SKAction.moveTo(x: buttonStartDefaultPosition.x, duration: SettingsGameProcess.Interface.Menu.StartButton.rotationSpeed)]),
                SKAction.scale(to: 1.0, duration: SettingsGameProcess.Interface.Menu.StartButton.backToNormalTime)])
            let otherButtonAnimation = SKAction.sequence([
                SKAction.wait(forDuration: SettingsGameProcess.Interface.Menu.StartButton.rotationSpeed),
                SKAction.scale(to: SettingsGameProcess.Interface.Menu.buttonsScaleTo, duration: SettingsGameProcess.Interface.Menu.buttonsScaleTime / 2),
                SKAction.scale(to: 1.0, duration: SettingsGameProcess.Interface.Menu.buttonsScaleTime / 2)])
            
            buttonStart.run(buttonStartAnimation)
            buttonRateUs.run(otherButtonAnimation)
            buttonTutorial.run(otherButtonAnimation)
            buttonGameCenter.run(otherButtonAnimation)
            buttonSettings.run(otherButtonAnimation)
            buttonStore.run(otherButtonAnimation)
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
            
            buttonStart.actionStartGame(ifInLocation: location)
            buttonRateUs.actionRateUs(ifInLocation: location)
            buttonStore.actionChangeScene(ifInLocation: location, withTransition: .pushLeft)
            buttonTutorial.actionChangeScene(ifInLocation: location, withTransition: .pushLeft)
            buttonGameCenter.actionShowGameCenter(ifInLocation: location)
            buttonSettings.actionChangeScene(ifInLocation: location, withTransition: .pushRight)
        }
    }
}
