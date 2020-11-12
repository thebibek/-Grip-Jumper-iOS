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

extension ButtonNode {
    
    //MARK: - Default actions
    func actionStartGame(ifInLocation location: CGPoint) {
        if contains(location) {
            let currentScene: GlobalScene = parent as! GlobalScene
            
            ///If play at first time show tutorial
            if !UserDefaults.standard.bool(forKey: "TutorialWasShown") {
                UserDefaults.standard.set(true, forKey: "TutorialOpenedWhenPressToStart")
                
                currentScene.loadScene(.tutorial, withTransitionName: .pushLeft)
            }
            else {
                currentScene.loadScene(.game, withTransitionName: .pushLeft)
            }
        }
    }
    
    func actionChangeScene(ifInLocation location: CGPoint, withTransition transition: GlobalScene.TransitionName) {
        if itsForChangingSceneButton {
            if contains(location) {
                let currentScene: GlobalScene = parent as! GlobalScene
                currentScene.loadScene(changeToSceneName, withTransitionName: transition)
            }
        }
    }
    
    func actionShowGameCenter(ifInLocation location: CGPoint) {
        if contains(location) { ExternalFunctions.showLeaderboard()}
    }
    
    func actionRateUs(ifInLocation location: CGPoint) {
        if contains(location) { ExternalFunctions.rateUs()}
    }
    
    func actionShare(ifInLocation location: CGPoint) {
        if contains(location) { ExternalFunctions.share()}
    }
    
    func actionRemoveAds(ifInLocation location: CGPoint) {
        if contains(location) { ExternalFunctions.buyRemoveAds()}
    }
    
    func actionRestorePurchases(ifInLocation location: CGPoint) {
        if contains(location) { ExternalFunctions.restorePurchases()}
    }
}

