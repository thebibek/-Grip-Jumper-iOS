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

class StoreSelectorNode: SimpleNode {
    
    /** This enum store possible states of store selector*/
    enum State {
        case buy
        case select
        case selected
    }
    
    //MARK: - Values
    var textureBuy: SKTexture?
    var textureSelect: SKTexture?
    var textureSelected: SKTexture?
    
    var labelPrice = SimpleLabel(text: "", fontSize: SettingsScenes.Store.FontSize.labelPrice, fontColorHex: SettingsScenes.Store.FontColor.labelPrice, position: SettingsScenes.Store.Position.labelPrice, zPosition: SettingsScenes.Store.ZPosition.labelPrice)
    
    //MARK: - Initialistions
    /**
     Initialisation of selector node
     - parameter textureBuy: SKTexture object of texture button in buy state.
     - parameter textureSelect: SKTexture object of texture button in select state.
     - parameter textureSelected: SKTexture object of texture button in selected state.
     - parameter size: CGSize object with size of node.
     - parameter position: CGPoint object for set position node on scene.
     - parameter zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    init() {
        super.init(texture: GraphicPreloadsInterface.preload.button_SkinSelected, size: SettingsScenes.Store.Size.buttonSelector, position: SettingsScenes.Store.Position.buttonSelector, zPosition: SettingsScenes.Store.ZPosition.buttonSelector)
        labelPrice.horizontalAlignmentMode = .left
        
        textureBuy = GraphicPreloadsInterface.preload.button_SkinBuy
        textureSelect = GraphicPreloadsInterface.preload.button_SkinSelect
        textureSelected = GraphicPreloadsInterface.preload.button_SkinSelected
        
        addChild(labelPrice)
    }
    
    /** If your custom init function not can run compiler call this function*/
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    
    //MARK: - Work with state
    /**
     Set right text for button for selected skin diring by his state.
     - parameter newState: Current state of this skin.
     */
    func set(state newState: State) {
        switch newState {
        case .buy:
            texture = textureBuy
            labelPrice.alpha = 1.0
        case .select:
            texture = textureSelect
            labelPrice.alpha = 0.0
        case .selected:
            texture = textureSelected
            labelPrice.alpha = 0.0
        }
    }
    
    /**
     Update price text for selected skin
     - parameter newPriveValue: Current skin price.
     */
    func set(priceValue newPriceValue: String) { labelPrice.text = newPriceValue}
}
