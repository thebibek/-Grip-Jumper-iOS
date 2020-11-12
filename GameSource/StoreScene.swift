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

class StoreScene: GlobalScene, SkinsHolderNodeDelegate {
    
    //MARK: Nodes
    fileprivate let background = BackgroundNode()
    fileprivate let buyResult = SimpleNode(texture: GraphicPreloadsInterface.preload.buyResult_Nice, size: SettingsScenes.Store.Size.buyResult, position: SettingsScenes.Store.Position.buyResult, zPosition: SettingsScenes.Store.ZPosition.buyResult)
    
    fileprivate let coinsIndicator = SimpleNode(texture: GraphicPreloadsInterface.preload.coinsIndicator, size: SettingsScenes.Store.Size.coinsIndicator, position: SettingsScenes.Store.Position.coinsIndicator, zPosition: SettingsScenes.Store.ZPosition.coinsIndicator)
    
    fileprivate let buttonBack = ButtonNode(defaultWithType: .back)
    
    fileprivate let buttonRemoveAds = ButtonNode(defaultWithType: .removeAds)
    fileprivate let buttonRestorePurchases = ButtonNode(defaultWithType: .restorePurchases)
    
    fileprivate let buttonNextSkin = ButtonNode(texture: GraphicPreloadsInterface.preload.button_SkinNext, size: SettingsScenes.Store.Size.buttonSkinNext, position: SettingsScenes.Store.Position.buttonSkinNext, zPosition: SettingsScenes.Store.ZPosition.buttonSkinNext)
    fileprivate let buttonPreviousSkin = ButtonNode(texture: GraphicPreloadsInterface.preload.button_SkinPrevious, size: SettingsScenes.Store.Size.buttonSkinPrevious, position: SettingsScenes.Store.Position.buttonSkinPrevious, zPosition: SettingsScenes.Store.ZPosition.buttonSkinPrevious)
    fileprivate let buttonStoreSelector = StoreSelectorNode()
    
    fileprivate let labelCoins = SimpleLabel(text: String(UserDefaults.standard.integer(forKey: "Coins")), fontSize: SettingsScenes.Store.FontSize.labelCoins, fontColorHex: SettingsScenes.Store.FontColor.labelCoins, position: SettingsScenes.Store.Position.labelCoins, zPosition: SettingsScenes.Store.ZPosition.labelCoins)
    
    fileprivate let skinHolder = SkinsHolderNode()
    fileprivate var showResultNow: Bool = false
    
    fileprivate let textStore = SimpleNode(texture: GraphicPreloadsInterface.preload.textStore, size: SettingsScenes.Store.Size.textStore, position: SettingsScenes.Store.Position.textStore, zPosition: SettingsScenes.Store.ZPosition.textStore)
    
    //MARK: - Scene life cycle
    override func didMove(to view: SKView) {
        ///Load node setting
        labelCoins.horizontalAlignmentMode = .left
        
        ///Add node to scene
        addChild([background, buttonBack, textStore])
        
        textStore.setInterfaceSize()
        buttonStoreSelector.setInterfaceSize()
        coinsIndicator.setInterfaceSize()
        
        if SettingsGlobal.InApp.on {
            if !UserDefaults.standard.bool(forKey: "adRemovedByPurchase") {
                addChild([buttonRemoveAds, buttonRestorePurchases])
            }
            if !SettingsGlobal.Skins.on {
                buttonRemoveAds.position = SettingsScenes.Store.Position.buttonRemoveAdsIfOnOnlyInApps
                buttonRestorePurchases.position = SettingsScenes.Store.Position.buttonRestorePurchasesIfOnOnlyInApps
            }
        }
        if SettingsGlobal.Skins.on {
            addChild([skinHolder, buttonNextSkin, buttonPreviousSkin, buttonStoreSelector, coinsIndicator, labelCoins])
            skinHolder.buttonStoreSelector = buttonStoreSelector
            skinHolder.delegate = self
            
            animateInterfaceSkinOn()
        }
    }
    
    //MARK: - Interface
    fileprivate func updateCoinIndicator() {
        labelCoins.changeTextWithAnimationScaled(withText: UserDefaults.standard.integer(forKey: "Coins"))
    }
    
    fileprivate func animateInterfaceSkinOn() {
        buttonNextSkin.position = CGPoint(x: SettingsGlobal.width * 1.5, y: buttonNextSkin.position.y)
        buttonPreviousSkin.position = CGPoint(x: -(SettingsGlobal.width / 2), y: buttonPreviousSkin.position.y)
        buttonStoreSelector.setScale(0.0)
        
        buttonNextSkin.run(SKAction.moveTo(x: SettingsScenes.Store.Position.buttonSkinNext.x, duration: SettingsGameProcess.Interface.Store.buttonSelecSkinAnimation))
        buttonPreviousSkin.run(SKAction.moveTo(x: SettingsScenes.Store.Position.buttonSkinPrevious.x, duration: SettingsGameProcess.Interface.Store.buttonSelecSkinAnimation))
        buttonStoreSelector.run(SKAction.scale(to: 1.0, duration: SettingsGameProcess.Interface.Store.buttonSelecSkinAnimation))
    }
    
    //MARK: Store skin functions
    /** Delegate from SkinHolderNode. Is return result for current skin purchase*/
    func skinHolderBuyResult(isSuccessfully successfully: Bool) {
        if successfully { updateCoinIndicator()}
        showBuyResult(withResult: successfully)
    }
    
    fileprivate func showBuyResult(withResult compleate: Bool) {
        showResultNow = true
        buyResult.texture = compleate ? GraphicPreloadsInterface.preload.buyResult_Nice : GraphicPreloadsInterface.preload.buyResult_Bad
        buyResult.run(SKAction.fadeIn(withDuration: 0))
        addChild(buyResult)
    }
    
    //MARK: - Input
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if !showResultNow {
                let location = touch.location(in: self)
                
                touchDownButtons(atLocation: location)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if !showResultNow {
                let location = touch.location(in: self)
                
                ///Change button state to simple state
                touchUpAllButtons()
                
                ///Buttons
                buttonBack.actionChangeScene(ifInLocation: location, withTransition: .pushRight)
                if !UserDefaults.standard.bool(forKey: "adRemovedByPurchase") {
                    buttonRemoveAds.actionRemoveAds(ifInLocation: location)
                    buttonRestorePurchases.actionRestorePurchases(ifInLocation: location)
                }
                if buttonNextSkin.contains(location) {
                    skinHolder.selectNextSkin()
                }
                if buttonPreviousSkin.contains(location) {
                    skinHolder.selectPreviousSkin()
                }
                if buttonStoreSelector.contains(location) {
                    skinHolder.pressToButtonStoreSelector()
                }
            }
            else {
                ///Remove result
                showResultNow = false
                buyResult.run(SKAction.sequence([
                    SKAction.fadeOut(withDuration: SettingsGameProcess.Interface.Store.resultBuySkinRemoveSpeed),
                    SKAction.removeFromParent()]))
            }
        }
    }
}
