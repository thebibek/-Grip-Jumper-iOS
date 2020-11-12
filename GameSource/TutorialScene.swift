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

class TutorialScene: GlobalScene {
    
    //MARK: Nodes
    fileprivate let background = BackgroundNode()
    fileprivate let indicatorCloseTutorial = SimpleNode(texture: GraphicPreloadsInterface.preload.indicatorCloseTutorial, size: SettingsScenes.Tutorial.Size.indicatorCloseTutorial, zPosition: SettingsScenes.Tutorial.ZPosition.indicatorCloseTutorial)
    
    //MARK: - Scene life cycle
    override func didMove(to view: SKView) {
        UserDefaults.standard.set(true, forKey: "TutorialWasShown")
        
        ///Setting nodes
        indicatorCloseTutorial.setToCenterByX()
        indicatorCloseTutorial.setToBorderOfScreenDownIncludeObjectSize()
        
        ///Add nodes to scene
        addChild(background)
        addChild(indicatorCloseTutorial)
        
        ///Run animations
        let oldPositionIndicatorCloseTutorial = indicatorCloseTutorial.position.y
        indicatorCloseTutorial.set(positionY: indicatorCloseTutorial.position.y - indicatorCloseTutorial.size.height)
        
        indicatorCloseTutorial.run(SKAction.moveTo(y: oldPositionIndicatorCloseTutorial, duration: SettingsGameProcess.Interface.Tutorial.IndicatorCloseTutorial.showTime))
    }
    
    fileprivate func closeTutorial() {
        ///If it's scene been show after pressed to start game at first change scene to game scene.
        if UserDefaults.standard.bool(forKey: "TutorialOpenedWhenPressToStart") {
            UserDefaults.standard.set(false, forKey: "TutorialOpenedWhenPressToStart")
            loadScene(.game, withTransitionName: .pushLeft)
        }
        else {
            loadScene(.menu, withTransitionName: .pushRight)
        }
    }
    
    //MARK: - Input
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        closeTutorial()
        Sound.sharedInstance().playSound(.buttonPress)
    }
}
